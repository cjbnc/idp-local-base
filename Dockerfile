FROM centos:centos7

MAINTAINER Charles Brabec <brabec@ncsu.edu>

ENV JRE_HOME /opt/jre1.8.0_65
ENV JAVA_HOME /opt/jre1.8.0_65
ENV JETTY_HOME /opt/jetty
ENV JETTY_BASE /opt/iam-jetty-base
ENV JETTY_MAX_HEAP 512m
ENV PATH $PATH:$JRE_HOME/bin:/opt/container-scripts

RUN yum -y update \
    && yum -y install tar unzip

# preloaded install files go to /tmp
ADD downloads/ /tmp/

# Install Java
RUN set -x; \
    java_version=8u65; \
    tar -zxvf /tmp/jre-$java_version-linux-x64.tar.gz -C /opt

# Base image does not have the JCE Unlimited rules
RUN set -x; \
    jce_version=8; \
    cd /tmp; \
    unzip -o jce_policy-$jce_version.zip \
    && mv -f UnlimitedJCEPolicyJDK$jce_version/*.jar $JRE_HOME/lib/security/ \
    && rm -rf UnlimitedJCEPolicyJDK$jce_version

# Install Jetty and initialize a new base
RUN set -x; \
    jetty_version=9.3.3.v20150827; \
    unzip /tmp/jetty-distribution-$jetty_version.zip -d /opt \
    && mv /opt/jetty-distribution-$jetty_version /opt/jetty \
    && cp /opt/jetty/bin/jetty.sh /etc/init.d/jetty \
    && mkdir -p /opt/iam-jetty-base/modules \
    && mkdir -p /opt/iam-jetty-base/lib/ext \
    && mkdir -p /opt/iam-jetty-base/resources \
    && cd /opt/iam-jetty-base \
    && touch start.ini \
    && $JRE_HOME/bin/java -jar ../jetty/start.jar --add-to-startd=http,https,deploy,ext,annotations,jstl,logging,setuid \
    && sed -i 's/# jetty.http.port=8080/jetty.http.port=80/g' /opt/iam-jetty-base/start.d/http.ini \
    && sed -i 's/# jetty.ssl.port=8443/jetty.ssl.port=443/g' /opt/iam-jetty-base/start.d/ssl.ini \
    && sed -i 's/<New id="DefaultHandler" class="org.eclipse.jetty.server.handler.DefaultHandler"\/>/<New id="DefaultHandler" class="org.eclipse.jetty.server.handler.DefaultHandler"><Set name="showContexts">false<\/Set><\/New>/g' /opt/jetty/etc/jetty.xml

# Place libsetuid
RUN set -x; \
    cp /tmp/libsetuid-8.1.9.v20130131.so /opt/iam-jetty-base/lib/ext/

# Install Shibboleth IdP
RUN set -x; \
    shibidp_version=3.2.0; \
    unzip /tmp/shibboleth-identity-provider-$shibidp_version.zip -d /opt \
    && cd /opt/shibboleth-identity-provider-$shibidp_version/ \
    && bin/install.sh -Didp.keystore.password=CHANGEME -Didp.sealer.password=CHANGEME -Didp.host.name=localhost.localdomain \
    && cd / \
    && chmod -R +r /opt/shibboleth-idp/ \
    && sed -i 's/ password/CHANGEME/g' /opt/shibboleth-idp/conf/idp.properties \
    && rm -r /opt/shibboleth-identity-provider-$shibidp_version/

# Place the library to allow SOAP Endpoints
RUN set -x; \
    cp /tmp/jetty9-dta-ssl-1.0.0.jar /opt/iam-jetty-base/lib/ext/

# Place the NCSU AD login module
RUN set -x; \
    cp /tmp/jaas-ncsuadloginmodule-1.0.7-1.0.jar \
       /opt/shibboleth-idp/webapp/WEB-INF/lib/

# extra config files
ADD iam-jetty-base/ /opt/iam-jetty-base/

# Clean up the install
RUN yum -y remove tar unzip; \
    yum clean all; \
    rm -rf /tmp/*

RUN useradd jetty -U -s /bin/false \
    && chown -R jetty:root /opt/jetty \
    && chown -R jetty:root /opt/iam-jetty-base \
    && chown -R jetty:root /opt/shibboleth-idp/logs

# startup script and friends
ADD container-scripts/ /opt/container-scripts/
RUN chmod -R +x /opt/container-scripts/

# we store backing files in metadata dir, so it must be writable
RUN chown -R jetty:root /opt/shibboleth-idp/metadata

# set container to log in our timezone
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# want external logs
VOLUME [ "/opt/iam-jetty-base/logs", \
         "/opt/shibboleth-idp/logs" ]

## Opening 443 (browser TLS), 8443 (SOAP/mutual TLS auth)... 80 specifically not included.
EXPOSE 443 8443

CMD ["run-shibboleth.sh"]

