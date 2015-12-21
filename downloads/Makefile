# pre-download all of the packages needed to build the docker image

# Oracle Java 1.8
JAVA_VER  := 8u65
JAVA_FILE := jre-$(JAVA_VER)-linux-x64.tar.gz
JAVA_SUM  := f8eae8d294e5856403f9ff0e306074f4f83d26c91c4c902f6c23c3d018ffc23f

# JCE Policy 
POLICY_VER  := 8
POLICY_FILE := jce_policy-$(POLICY_VER).zip
POLICY_SUM  := f3020a3922efd6626c2fff45695d527f34a8020e938a49292561f18ad1320b59

# Jetty
JETTY_VER  := 9.3.6.v20151106
JETTY_FILE := jetty-distribution-$(JETTY_VER).zip
JETTY_SUM  := 9dfe91cb306b67d58857bfa1aace0bd303e4e3d1

# libsetuid for Jetty
LIBSETUID_VER  := 8.1.9.v20130131
LIBSETUID_FILE := libsetuid-$(LIBSETUID_VER).so
LIBSETUID_SUM  := 7286c7cb836126a403eb1c2c792bde9ce6018226

# Shibboleth IdP
IDP_VER  := 3.2.1
IDP_FILE := shibboleth-identity-provider-$(IDP_VER).zip
IDP_SUM  := 9d509e4c54cba5de8b63fba9a59c90138f289f8126ab7849f8a42392432a1317

# library to allow SOAP Endpoints
DTA_VER  := 1.0.0
DTA_FILE := jetty9-dta-ssl-$(DTA_VER).jar
DTA_SUM  := 2f547074b06952b94c35631398f36746820a7697

# NCSU custom LoginHandler
NCSUAD_VER  := 1.0.7-1.1
NCSUAD_FILE := jaas-ncsuadloginmodule-$(NCSUAD_VER).jar 
NCSUAD_SUM  := 89096c30a79750173d2e15a721ed19676d2d68e9

.PHONY: all clean

all: $(JAVA_FILE) $(POLICY_FILE) \
	 $(JETTY_FILE) $(LIBSETUID_FILE) \
	 $(IDP_FILE) $(DTA_FILE) $(NCSUAD_FILE)

clean:
	rm -f $(JAVA_FILE) $(POLICY_FILE) \
		  $(JETTY_FILE) $(LIBSETUID_FILE) \
		  $(IDP_FILE) $(DTA_FILE) $(NCSUAD_FILE)

$(JAVA_FILE):
	wget -O $(JAVA_FILE) \
		--no-check-certificate --no-cookies \
		--header "Cookie: oraclelicense=accept-securebackup-cookie" \
		http://download.oracle.com/otn-pub/java/jdk/$(JAVA_VER)-b17/$(JAVA_FILE)
	echo "$(JAVA_SUM)  $(JAVA_FILE)" | sha256sum -c -

$(POLICY_FILE):
	wget -O $(POLICY_FILE) \
		--no-check-certificate --no-cookies \
		--header "Cookie: oraclelicense=accept-securebackup-cookie" \
		http://download.oracle.com/otn-pub/java/jce/$(POLICY_VER)/$(POLICY_FILE)
	echo "$(POLICY_SUM)  $(POLICY_FILE)" | sha256sum -c -

$(JETTY_FILE):
	wget -O $(JETTY_FILE) \
		"https://eclipse.org/downloads/download.php?file=/jetty/$(JETTY_VER)/dist/$(JETTY_FILE)&r=1"
	echo "$(JETTY_SUM)  $(JETTY_FILE)" | sha1sum -c -

$(LIBSETUID_FILE):
	wget -O $(LIBSETUID_FILE) \
		https://repo1.maven.org/maven2/org/mortbay/jetty/libsetuid/$(LIBSETUID_VER)/$(LIBSETUID_FILE)
	echo "$(LIBSETUID_SUM)  $(LIBSETUID_FILE)" | sha1sum -c -

$(IDP_FILE):
	wget -O $(IDP_FILE) \
		https://shibboleth.net/downloads/identity-provider/$(IDP_VER)/$(IDP_FILE)
	echo "$(IDP_SUM)  $(IDP_FILE)" | sha256sum -c -

$(DTA_FILE):
	wget -O $(DTA_FILE) \
		https://build.shibboleth.net/nexus/content/repositories/releases/net/shibboleth/utilities/jetty9/jetty9-dta-ssl/$(DTA_VER)/$(DTA_FILE)
	echo "$(DTA_SUM)  $(DTA_FILE)" | sha1sum -c -

$(NCSUAD_FILE): /afs/unity/web/s/shib/src/$(NCSUAD_FILE)
	cp -f /afs/unity/web/s/shib/src/$(NCSUAD_FILE) $(NCSUAD_FILE)
	# echo "$(NCSUAD_SUM)  $(NCSUAD_FILE)" | sha1sum -c -

