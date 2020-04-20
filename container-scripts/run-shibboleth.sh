#!/bin/sh
set -x

# JAVA_HOME already set in docker environment
export JETTY_HOME=/opt/jetty/
export JETTY_BASE=/opt/iam-jetty-base/
export PATH=$PATH:$JAVA_HOME/bin

# does this container use cron?
[ -d /opt/cron-scripts ] && crond -s

# make sure configs are up to date
[ -x /opt/cron-scripts/update_configs.sh ] \
  && /opt/cron-scripts/update_configs.sh

sed -i "s/^-Xmx.*$/-Xmx$JETTY_MAX_HEAP/g" /opt/iam-jetty-base/start.ini

/etc/init.d/jetty run
