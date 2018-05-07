# pre-download all of the packages needed to build the docker image

# Oracle Java 1.8
JAVA_VER  := 8u172
JAVA_PATH := 8u172-b11/a58eab1ec242421181065cdc37240b08
JAVA_FILE := jre-$(JAVA_VER)-linux-x64.tar.gz
JAVA_SUM  := f08f25aec2bdc86138ccba8fd5b904451e3afa1d24a88c85f28c2d84bfd45bad

# JCE Policy 
POLICY_VER  := 8
POLICY_FILE := jce_policy-$(POLICY_VER).zip
POLICY_SUM  := f3020a3922efd6626c2fff45695d527f34a8020e938a49292561f18ad1320b59

# Jetty
JETTY_VER  := 9.4.9.v20180320
JETTY_FILE := jetty-distribution-$(JETTY_VER).zip
JETTY_SUM  := 76271825b5e01169ba3905affda6a353244aa174

# libsetuid for Jetty
LIBSETUID_VER  := 8.1.9.v20130131
LIBSETUID_FILE := libsetuid-$(LIBSETUID_VER).so
LIBSETUID_SUM  := 7286c7cb836126a403eb1c2c792bde9ce6018226

# Shibboleth IdP
IDP_VER  := 3.3.2
IDP_FILE := shibboleth-identity-provider-$(IDP_VER).zip
IDP_SUM  := 26408913a75f2a0228a0f51a42eaffc9dd449f762bc71b54e3a100aa4db013a7

# library to allow SOAP Endpoints
DTA_VER  := 1.0.0
DTA_FILE := jetty9-dta-ssl-$(DTA_VER).jar
DTA_SUM  := 2f547074b06952b94c35631398f36746820a7697

# NCSU custom LoginHandler
NCSUAD_VER  := 1.0.7-1.1
NCSUAD_FILE := jaas-ncsuadloginmodule-$(NCSUAD_VER).jar 
NCSUAD_SUM  := 89096c30a79750173d2e15a721ed19676d2d68e9

# URL Rewrite Lib
REWRITE_VER  := 4.0.3
REWRITE_FILE := urlrewritefilter-$(REWRITE_VER).jar
REWRITE_SUM  := 1a4b56629cacf3ec8d530405af2db018a679575e

# Duo Client Plugin
DUO_VER  := 0.2.1
DUO_FILE := duo-client-$(DUO_VER).jar
DUO_SUM  := 2d1b8939f3f00b1655127ec4764bd05753448bb4
DUOS1_VER  := chargebee-1.0
DUOS1_FILE := org.json-$(DUOS1_VER).jar
DUOS2_VER  := 2.3.0
DUOS2_FILE := okhttp-$(DUOS2_VER).jar


.PHONY: all clean

all: $(JAVA_FILE) $(POLICY_FILE) \
	 $(JETTY_FILE) $(LIBSETUID_FILE) \
	 $(IDP_FILE) $(DTA_FILE) $(NCSUAD_FILE) \
	 $(REWRITE_FILE) $(DUO_FILE)

clean:
	rm -f $(JAVA_FILE) $(POLICY_FILE) \
		  $(JETTY_FILE) $(LIBSETUID_FILE) \
		  $(IDP_FILE) $(DTA_FILE) $(NCSUAD_FILE) \
		  $(REWRITE_FILE) $(DUO_FILE)

$(JAVA_FILE):
	wget -O $(JAVA_FILE) \
		--no-check-certificate --no-cookies \
		--header "Cookie: oraclelicense=accept-securebackup-cookie" \
		http://download.oracle.com/otn-pub/java/jdk/$(JAVA_PATH)/$(JAVA_FILE)
	echo "$(JAVA_SUM)  $(JAVA_FILE)" | sha256sum -c -

$(POLICY_FILE):
	wget -O $(POLICY_FILE) \
		--no-check-certificate --no-cookies \
		--header "Cookie: oraclelicense=accept-securebackup-cookie" \
		http://download.oracle.com/otn-pub/java/jce/$(POLICY_VER)/$(POLICY_FILE)
	echo "$(POLICY_SUM)  $(POLICY_FILE)" | sha256sum -c -

$(JETTY_FILE):
	wget -O $(JETTY_FILE) \
		http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/$(JETTY_VER)/$(JETTY_FILE)
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

$(REWRITE_FILE):
	wget -O $(REWRITE_FILE) \
	    http://central.maven.org/maven2/org/tuckey/urlrewritefilter/$(REWRITE_VER)/$(REWRITE_FILE)
	echo "$(REWRITE_SUM)  $(REWRITE_FILE)" | sha1sum -c -

$(DUO_FILE): $(DUOS1_FILE) $(DUOS2_FILE)
	wget -O $(DUO_FILE) \
		https://dl.bintray.com/uniconiam/maven/com/duosecurity/duo-client/$(DUO_VER)/$(DUO_FILE)
	echo "$(DUO_SUM)  $(DUO_FILE)" | sha1sum -c -

$(DUOS1_FILE):
	wget -O $(DUOS1_FILE) \
		http://repo1.maven.org/maven2/org/json/org.json/$(DUOS1_VER)/$(DUOS1_FILE)

$(DUOS2_FILE):
	wget -O $(DUOS2_FILE) \
		http://repo1.maven.org/maven2/com/squareup/okhttp/okhttp/$(DUOS2_VER)/$(DUOS2_FILE)


