#!/bin/bash
# make a copy of the current sealer key files
# then update the key version

IDPHOME=/opt/shibboleth-idp
KEYDIR=/tmp/sealer
KEYPASS=$(grep '^idp.sealer.storePassword' $IDPHOME/conf/idp.properties | \
  cut -d = -f 2)

# this will only work if the container already has the latest key
#[ -d $KEYDIR ] || mkdir -p $KEYDIR
#cp -f $IDPHOME/credentials/sealer.jks  $KEYDIR/sealer.jks
#cp -f $IDPHOME/credentials/sealer.kver $KEYDIR/sealer.kver

# this dir must already have the newest keys files
# setup by the external cron caller
( [ -d $KEYDIR ] \
  && [ -s "$KEYDIR/sealer.jks" ] \
  && [ -s "$KEYDIR/sealer.kver" ] ) \
  || exit

$IDPHOME/bin/seckeygen.sh \
  --storefile $KEYDIR/sealer.jks \
  --versionfile $KEYDIR/sealer.kver \
  --alias secret \
  --count 6 \
  --storepass $KEYPASS
