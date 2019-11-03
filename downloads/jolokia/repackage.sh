#!/bin/bash

rm -rf WEB-INF META-INF
unzip ../jolokia-war-unsecured-1.6.2.war
cp jolokia-access.xml WEB-INF/classes/
zip -vr ../jolokia-localhost.war WEB-INF META-INF

