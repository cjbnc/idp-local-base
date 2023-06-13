#!/bin/bash -x

OIDCVER=2.2.1
DUOVER=1.4.0

cd /opt/shibboleth-idp
bin/plugin.sh --noPrompt \
  --truststore /opt/idp-plugins/trust-oidc-common.txt \
  -i /opt/idp-plugins/oidc-common-dist-${OIDCVER}.tar.gz
bin/plugin.sh --noPrompt \
  --truststore /opt/idp-plugins/trust-duo-sdk.txt \
  -i /opt/idp-plugins/idp-plugin-duo-sdk-dist-${DUOVER}.tar.gz

