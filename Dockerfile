FROM centos:centos7
MAINTAINER Charles Brabec <brabec@ncsu.edu>

# all the envs in one layer
ENV JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto \
    JETTY_HOME=/opt/jetty \
    JETTY_BASE=/opt/iam-jetty-base \
    JETTY_MAX_HEAP=512m \
    DUO_BASE=/opt/duo_shibboleth \
    PATH=$PATH:$JRE_HOME/bin:/opt/container-scripts \
    TZ=America/New_York

# make sure centos is up to date
# build tools: tar unzip
# standard tools missing from base: which
# wants cron: cronie
# set our timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && yum -y update \
    && yum -y install tar unzip which cronie \
    && yum clean all \
    && rm -rf /tmp/* /var/cache/yum

# preloaded install files go to /tmp
ADD downloads/ /tmp/

# Install Amazon Corretto Java 
RUN rpm --import /tmp/corretto-signing-key.pub \
    && rpm -i /tmp/amazon-corretto-11-x64-linux-jdk.rpm
    
# Install Jetty and initialize a new base
RUN set -x; \
    jetty_version=9.4.36.v20210114; \
    unzip /tmp/jetty-distribution-$jetty_version.zip -d /opt \
    && mv /opt/jetty-distribution-$jetty_version /opt/jetty \
    && cp /opt/jetty/bin/jetty.sh /etc/init.d/jetty \
    && mkdir -p /opt/iam-jetty-base/modules \
    && mkdir -p /opt/iam-jetty-base/lib/ext \
    && mkdir -p /opt/iam-jetty-base/resources \
    && cd /opt/iam-jetty-base \
    && touch start.ini \
    && $JRE_HOME/bin/java -jar ../jetty/start.jar --create-startd --add-to-start=http,https,ssl,deploy,ext,annotations,jstl,console-capture,setuid \
    && sed -i 's/# jetty.http.port=8080/jetty.http.port=80/g' /opt/iam-jetty-base/start.d/http.ini \
    && sed -i 's/# jetty.ssl.port=8443/jetty.ssl.port=443/g' /opt/iam-jetty-base/start.d/ssl.ini \
    && sed -i 's/<New id="DefaultHandler" class="org.eclipse.jetty.server.handler.DefaultHandler"\/>/<New id="DefaultHandler" class="org.eclipse.jetty.server.handler.DefaultHandler"><Set name="showContexts">false<\/Set><\/New>/g' /opt/jetty/etc/jetty.xml 

# Place libsetuid
RUN set -x; \
    cp /tmp/libsetuid-8.1.9.v20130131.so /opt/iam-jetty-base/lib/ext/

# Install Shibboleth IdP
RUN set -x; \
    shibidp_version=4.0.1; \
    unzip /tmp/shibboleth-identity-provider-$shibidp_version.zip -d /opt \
    && cd /opt/shibboleth-identity-provider-$shibidp_version/ \
    && bin/install.sh -Didp.noprompt=true \
         -Didp.property.file=/tmp/idp/idp.installer.properties \
    && cd / \
    && chmod -R +r /opt/shibboleth-idp/ \
    && sed -i 's/ password/CHANGEME/g' /opt/shibboleth-idp/conf/idp.properties \
    && rm -r /opt/shibboleth-identity-provider-$shibidp_version/

# Place the library to allow SOAP Endpoints
# Place the URL Rewrite Filter jar
# Place the NCSU AD login module
# Place the jars needed for Duo client in MFA
RUN set -x; \
    cp /tmp/jetty9-dta-ssl-1.0.0.jar /opt/iam-jetty-base/lib/ext/ && \
    cp /tmp/urlrewritefilter-4.0.3.jar /opt/iam-jetty-base/lib/ext/ && \
    cp /tmp/jaas-ncsuadloginmodule-1.3.0-1.0.jar \
       /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/ && \
    cp /tmp/duo-client-0.2.1.jar \
       /tmp/org.json-chargebee-1.0.jar \
       /tmp/okhttp-2.3.0.jar \
       /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/

# Jolokia war for stats
RUN set -x; \
    mkdir -p /opt/jolokia; \
    cp /tmp/jolokia-localhost.war /opt/jolokia/jolokia.war

# extra config files
ADD iam-jetty-base/ /opt/iam-jetty-base/
ADD shibboleth-idp/ /opt/shibboleth-idp/
ADD container-scripts/ /opt/container-scripts/
ADD cron-scripts/ /opt/cron-scripts/

# Clean up the install
RUN yum -y remove unzip; \
    yum clean all; \
    rm -rf /tmp/* /var/cache/yum

# set perms, making sure metadata and logs are writable
# startup script and friends
RUN useradd jetty -U -s /bin/false \
    && chown -R jetty:root /opt/jetty \
    && chown -R jetty:root /opt/iam-jetty-base \
    && chown -R jetty:root /opt/shibboleth-idp/logs \
    && chown -R jetty:root /opt/shibboleth-idp/metadata \
    && chmod -R +x /opt/container-scripts/ \
    && crontab /opt/cron-scripts/crontab

# want external logs
VOLUME [ "/opt/iam-jetty-base/logs", \
         "/opt/shibboleth-idp/logs" ]

## Opening 80 (for local checks only), 443 (browser TLS), 8443 (SOAP/mutual TLS auth)
EXPOSE 80 443 8443

#establish a healthcheck command so that docker might know the container's true state
HEALTHCHECK --interval=2m --timeout=30s \
  CMD curl -kfs https://127.0.0.1/idp/status || exit 1

CMD ["run-shibboleth.sh"]

