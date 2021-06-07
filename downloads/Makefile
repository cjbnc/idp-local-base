# pre-download all of the packages needed to build the docker image

# Corretto Java JDK
JAVA_VER  := 11
JAVA_FILE := amazon-corretto-$(JAVA_VER)-x64-linux-jdk.rpm

# Jetty
JETTY_VER  := 9.4.41.v20210516
JETTY_FILE := jetty-distribution-$(JETTY_VER).zip
JETTY_SUM  := 233b8ec23e5b6d6ed812a687a8c41d8cf6fa6c30e9f1e742c4aba59643e9522f

# libsetuid for Jetty
LIBSETUID_VER  := 8.1.9.v20130131
LIBSETUID_FILE := libsetuid-$(LIBSETUID_VER).so
LIBSETUID_SUM  := 7286c7cb836126a403eb1c2c792bde9ce6018226

# Shibboleth IdP
IDP_VER  := 4.1.2
IDP_FILE := shibboleth-identity-provider-$(IDP_VER).zip
IDP_SUM  := 17f192dd8082cd4b527080224406e1e88a1679155860f8f09aa66b8e22f42178

# library to allow SOAP Endpoints
DTA_VER  := 1.0.0
DTA_FILE := jetty9-dta-ssl-$(DTA_VER).jar
DTA_SUM  := 2f547074b06952b94c35631398f36746820a7697

# NCSU custom LoginHandler
NCSUAD_VER  := 1.3.0-1.0
NCSUAD_FILE := jaas-ncsuadloginmodule-$(NCSUAD_VER).jar 

# URL Rewrite Lib
REWRITE_VER  := 4.0.3
REWRITE_FILE := urlrewritefilter-$(REWRITE_VER).jar
REWRITE_SUM  := 1a4b56629cacf3ec8d530405af2db018a679575e

# Jolokia JMX connector
JOLOKIA_VER  := 1.6.2
#JOLOKIA_FILE := jolokia-war-$(JOLOKIA_VER).war
#JOLOKIA_SUM  := 493d8bcde429c15a94c7bedcc4d9fc33cddc899243dcf0f19692348af6583c4d
JOLOKIA_FILE := jolokia-war-unsecured-$(JOLOKIA_VER).war
JOLOKIA_SUM  := 8cc4a6260b1a2ec72cf184a3447cc040a0436ad8602b5644da95884ed03426c2

# Duo Client Plugin
DUO_VER  := 0.3.0
DUO_FILE := duo-client-$(DUO_VER).jar
DUO_SUM  := 2c71c5e8b9993c8f605974321c228ac6d3e0c999
DUOS1_VER  := chargebee-1.0
DUOS1_FILE := org.json-$(DUOS1_VER).jar
DUOS2_VER  := 2.3.0
DUOS2_FILE := okhttp-$(DUOS2_VER).jar
DUOS3_VER  := 1.15.0
DUOS3_FILE := okio-$(DUOS3_VER).jar

# IdP Plugins, will grab the .asc files as well
PLUG1_VER  := 1.0.0
PLUG1_FILE := oidc-common-dist-$(PLUG1_VER).tar.gz
PLUG2_VER  := 1.0.0
PLUG2_FILE := idp-plugin-duo-sdk-dist-$(PLUG1_VER).tar.gz

.PHONY: all clean

all: $(JETTY_FILE) $(LIBSETUID_FILE) \
	 $(IDP_FILE) $(DTA_FILE) $(NCSUAD_FILE) \
	 $(REWRITE_FILE) $(JOLOKIA_FILE) $(DUO_FILE) \
	 $(PLUG1_FILE) $(PLUG2_FILE)

clean:
	rm -f $(JETTY_FILE) $(LIBSETUID_FILE) \
		  $(IDP_FILE) $(DTA_FILE) $(NCSUAD_FILE) \
		  $(REWRITE_FILE) $(JOLOKIA_FILE) $(DUO_FILE) \
		  $(PLUG1_FILE) $(PLUG1_FILE).asc \
		  $(PLUG2_FILE) $(PLUG2_FILE).asc

$(JETTY_FILE):
	wget -O $(JETTY_FILE) \
		https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/$(JETTY_VER)/$(JETTY_FILE)
	echo "$(JETTY_SUM)  $(JETTY_FILE)" | sha256sum -c -

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

$(REWRITE_FILE):
	wget -O $(REWRITE_FILE) \
	    https://repo1.maven.org/maven2/org/tuckey/urlrewritefilter/$(REWRITE_VER)/$(REWRITE_FILE)
	echo "$(REWRITE_SUM)  $(REWRITE_FILE)" | sha1sum -c -

$(JOLOKIA_FILE):
	wget -O $(JOLOKIA_FILE) \
	    https://repo1.maven.org/maven2/org/jolokia/jolokia-war-unsecured/$(JOLOKIA_VER)/$(JOLOKIA_FILE)
	echo "$(JOLOKIA_SUM)  $(JOLOKIA_FILE)" | sha256sum -c -

jolokia-localhost.war: $(JOLOKIA_FILE)
	(cd jolokia; sh repackage.sh)

$(DUO_FILE): $(DUOS1_FILE) $(DUOS2_FILE) $(DUOS3_FILE)
	wget -O $(DUO_FILE) \
		https://repo1.maven.org/maven2/com/duosecurity/duo-client/$(DUO_VER)/$(DUO_FILE)
	echo "$(DUO_SUM)  $(DUO_FILE)" | sha1sum -c -

$(DUOS1_FILE):
	wget -O $(DUOS1_FILE) \
		https://repo1.maven.org/maven2/org/json/org.json/$(DUOS1_VER)/$(DUOS1_FILE)

$(DUOS2_FILE):
	wget -O $(DUOS2_FILE) \
		https://repo1.maven.org/maven2/com/squareup/okhttp/okhttp/$(DUOS2_VER)/$(DUOS2_FILE)

$(DUOS3_FILE):
	wget -O $(DUOS3_FILE) \
		https://repo1.maven.org/maven2/com/squareup/okio/okio/$(DUOS3_VER)/$(DUOS3_FILE)

$(PLUG1_FILE):
	wget -O $(PLUG1_FILE) \
	    https://shibboleth.net/downloads/identity-provider/plugins/oidc-common/$(PLUG1_VER)/$(PLUG1_FILE)
	wget -O $(PLUG1_FILE).asc \
	    https://shibboleth.net/downloads/identity-provider/plugins/oidc-common/$(PLUG1_VER)/$(PLUG1_FILE).asc

$(PLUG2_FILE):
	wget -O $(PLUG2_FILE) \
	    https://shibboleth.net/downloads/identity-provider/plugins/duo-oidc/$(PLUG2_VER)/$(PLUG2_FILE)
	wget -O $(PLUG2_FILE).asc \
	    https://shibboleth.net/downloads/identity-provider/plugins/duo-oidc/$(PLUG2_VER)/$(PLUG2_FILE).asc

