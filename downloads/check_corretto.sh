#!/bin/bash

fname=amazon-corretto-17-x64-linux-jdk.rpm
url=https://corretto.aws/downloads/latest/$fname
hfile=./.last_coretto

newver=$(curl -v $url 2>&1 | grep Location:)
oldver=$(cat $hfile)

if [ "$oldver" != "$newver" ]; then
  echo $newver > $hfile
  #rm -f $fname
  #make
  echo "Build will download:"
  echo "  $newver"
else
  echo "Current   $newver"
fi
