FROM rockylinux:8 as javabase

# all the envs 
ENV JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto \
    JETTY_HOME=/opt/jetty \
    JETTY_BASE=/opt/iam-jetty-base \
    JETTY_MAX_HEAP=512m \
    DUO_BASE=/opt/duo_shibboleth \
    PATH=$PATH:$JRE_HOME/bin:/opt/container-scripts \
    TZ=America/New_York

# make sure centos is up to date
# build tools: unzip
# wants: cronie which
# set our timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && dnf -y update \
    && rpm --import https://yum.corretto.aws/corretto.key \
    && curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo \
    && dnf -y install java-17-amazon-corretto-devel unzip cronie which \
       findutils procps-ng psmisc \
    && dnf clean all \
    && rm -rf /tmp/* /var/cache/dnf

# need the same java env to build out /opt
FROM javabase as build

# preloaded install files go to /tmp
ADD downloads/ /tmp/

# Install Jetty and initialize a new base
RUN set -x; \
    jetty_version=11.0.19; \
    unzip /tmp/jetty-home-$jetty_version.zip -d /opt \
    && mv /opt/jetty-home-$jetty_version /opt/jetty \
    && cp /opt/jetty/bin/jetty.sh /etc/init.d/jetty \
    && sed -i "s/\(xargs.*\)&/\1/" /etc/init.d/jetty \
    && mkdir -p /opt/iam-jetty-base/modules \
    && mkdir -p /opt/iam-jetty-base/lib/ext \
    && mkdir -p /opt/iam-jetty-base/resources \
    && cd /opt/iam-jetty-base \
    && $JRE_HOME/bin/java -jar ../jetty/start.jar --create-startd --add-module=server,http,https,ssl,deploy,annotations,resources,console-capture,setuid,rewrite,logging-logback,servlets,jsp,jstl,ext,plus --approve-all-licenses \
    && sed -i 's/# jetty.http.port=8080/jetty.http.port=80/g' /opt/iam-jetty-base/start.d/http.ini \
    && sed -i 's/# jetty.ssl.port=8443/jetty.ssl.port=443/g' /opt/iam-jetty-base/start.d/ssl.ini 

# Install Shibboleth IdP
RUN set -x; \
    shibidp_version=5.0.0; \
    unzip /tmp/shibboleth-identity-provider-$shibidp_version.zip -d /opt \
    && cd /opt/shibboleth-identity-provider-$shibidp_version/ \
    && bin/install.sh --noPrompt \
         --propertyFile /tmp/idp/idp.installer.properties \
    && cd / \
    && chmod -R +r /opt/shibboleth-idp/ \
    && sed -i 's/ password/CHANGEME/g' /opt/shibboleth-idp/conf/idp.properties \
    && rm -r /opt/shibboleth-identity-provider-$shibidp_version/

# copy IdP Plugins so they can be installed later
RUN set -x; \
    mkdir -p /opt/idp-plugins; \
    cp /tmp/oidc-common-dist-3.0.0.tar.gz \
       /tmp/oidc-common-dist-3.0.0.tar.gz.asc \
       /tmp/idp-plugin-duo-sdk-dist-2.0.0.tar.gz \
       /tmp/idp-plugin-duo-sdk-dist-2.0.0.tar.gz.asc \
       /tmp/idp-plugin-nashorn-jdk-dist-2.0.0.tar.gz \
       /tmp/idp-plugin-nashorn-jdk-dist-2.0.0.tar.gz.asc \
       /tmp/trust-duo-sdk.txt \
       /tmp/trust-oidc-common.txt \
       /tmp/trust-nashorn.txt \
       /tmp/add_duo_plugins.sh \
       /opt/idp-plugins

# Place the library to allow SOAP Endpoints
# Place the URL Rewrite Filter jar
# Place the NCSU AD login module
# Place the jars needed for Duo client in MFA
RUN set -x; \
    mkdir -p /opt/shibboleth-idp/edit-webapp/WEB-INF/lib && \
    cp /tmp/jaas-ncsuadloginmodule-2.2.0-1.0.jar \
       /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/ && \
    cp /tmp/duo-client-0.3.0.jar \
       /tmp/org.json-chargebee-1.0.jar \
       /tmp/okio-1.15.0.jar \
       /tmp/okhttp-2.3.0.jar \
       /opt/shibboleth-idp/edit-webapp/WEB-INF/lib/

# extra config files
ADD iam-jetty-base/ /opt/iam-jetty-base/
ADD shibboleth-idp/ /opt/shibboleth-idp/
ADD container-scripts/ /opt/container-scripts/
ADD cron-scripts/ /opt/cron-scripts/

# start the real container
FROM javabase
MAINTAINER Charles Brabec <brabec@ncsu.edu>

# just grab the installed pieces without all the source
COPY --from=build /opt /opt
COPY --from=build /etc/init.d/jetty /etc/init.d/jetty

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
  CMD curl -fs --ipv4 http://localhost/idp/status || exit 1

CMD ["run-shibboleth.sh"]

