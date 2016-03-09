#!/bin/sh
#
# copy files with subdir paths
# from /opt/idp-config-src/shibboleth-idp
#   to /opt/shibboleth-idp
# with chown and taking care to check for empty source files

TOUCHFILE=/tmp/idp-config-update.log
VERBOSE=0
while [[ $# > 0 ]]; do
  key="$1"
  case $key in
    -v|--verbose)
    VERBOSE=1
    ;;
  esac
  shift
done

files=$(find /opt/idp-config-src/shibboleth-idp -type f)
for src in $files; do
  dst=${src/idp-config-src?/}
  [ $VERBOSE == 1 ] && echo "Checking $src"
  if [ -r "$src" -a -s "$src" ]; then
    if [ "$src" -nt "$dst" ]; then
      [ $VERBOSE == 1 ] && echo "    copy to $dst"
      /bin/cp -f "$src" "$dst"
      /bin/chown root.root "$dst"
      /bin/date +%s > $TOUCHFILE
    fi
  else
    echo "WARN: unreadable or empty file: $src"
  fi
done
