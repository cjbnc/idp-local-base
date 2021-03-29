# source of the trust\-\*.txt files

After downloading the IdP plugins for oidc-common and duo-sdk, the public
key files that were used for signing can be extracted from the tarballs.
Or, just use the copies saved in this repo.

```
cd /tmp
tar xzf ~/idp41-local-base/downloads/oidc-common-dist-1.0.0.tar.gz
cp shibboleth-idp-plugin-oidc-common-1.0.0/bootstrap/keys.txt \
    ~/idp41-local-base/downloads/trust-oidc-common.txt
```
