#FROM unicon/shibboleth-idp
FROM ncsuoit/shibboleth-idp

# need these tools again
RUN yum -y install wget tar unzip

# Base image does not have the JCE Unlimited rules
RUN set -x; \
    jce_version=8; \
    cd /tmp; \
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jce/$jce_version/jce_policy-$jce_version.zip \
    && echo "f3020a3922efd6626c2fff45695d527f34a8020e938a49292561f18ad1320b59  jce_policy-$jce_version.zip" | sha256sum -c - \
    && unzip -o jce_policy-$jce_version.zip \
    && mv -f UnlimitedJCEPolicyJDK$jce_version/*.jar $JRE_HOME/lib/security/ \
    && rm -rf jce_policy-$jce_version.zip UnlimitedJCEPolicyJDK$jce_version

# when we are finished with these, clean them out again
RUN yum -y remove wget tar unzip; yum clean all

# we store backing files in metadata dir, so it must be writable
RUN chown -R jetty:root /opt/shibboleth-idp/metadata

# set container to log in our timezone
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# want external logs
VOLUME ["/opt/shibboleth-idp/logs", "/opt/iam-jetty-base/logs"]

