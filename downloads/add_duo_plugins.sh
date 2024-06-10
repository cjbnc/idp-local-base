#!/bin/bash -x

OIDCVER=3.1.0
DUOVER=2.1.0
JSVER=2.0.0

cd /opt/shibboleth-idp
bin/plugin.sh --noPrompt \
  --truststore /opt/idp-plugins/trust-oidc-common.txt \
  -i /opt/idp-plugins/oidc-common-dist-${OIDCVER}.tar.gz
bin/plugin.sh --noPrompt \
  --truststore /opt/idp-plugins/trust-duo-sdk.txt \
  -i /opt/idp-plugins/idp-plugin-duo-sdk-dist-${DUOVER}.tar.gz
bin/plugin.sh --noPrompt \
  --truststore /opt/idp-plugins/trust-nashorn.txt \
  -i /opt/idp-plugins/idp-plugin-nashorn-jdk-dist-${JSVER}.tar.gz

