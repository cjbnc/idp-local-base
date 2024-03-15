# pre-download all of the packages needed to build the docker image

# Corretto Java JDK
JAVA_VER  := 11
JAVA_FILE := amazon-corretto-$(JAVA_VER)-x64-linux-jdk.rpm

# Jetty
JETTY_VER  := 11.0.19
JETTY_FILE := jetty-home-$(JETTY_VER).zip
JETTY_SUM  := 77c3c7168f042e9dbc0e4149923e561788c1bd067c1d2e7cb6edaace6d54a26b

# Shibboleth IdP
IDP_VER  := 5.1.0
IDP_FILE := shibboleth-identity-provider-$(IDP_VER).zip
IDP_SUM  := 7877525c0f6d75684f86dd3203c0a147cb41937d3fb2e5361b3f3c76e8170208

# NCSU custom LoginHandler
NCSUAD_VER  := 2.2.0-1.0
NCSUAD_FILE := jaas-ncsuadloginmodule-$(NCSUAD_VER).jar 

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
PLUG1_VER  := 3.0.0
PLUG1_FILE := oidc-common-dist-$(PLUG1_VER).tar.gz
PLUG2_VER  := 2.0.0
PLUG2_FILE := idp-plugin-duo-sdk-dist-$(PLUG2_VER).tar.gz
PLUG3_VER  := 2.0.0
PLUG3_FILE := idp-plugin-nashorn-jdk-dist-$(PLUG3_VER).tar.gz
ADD_PLUGS  := add_duo_plugins.sh

.PHONY: all clean

all: $(JETTY_FILE) $(IDP_FILE) $(NCSUAD_FILE) $(DUO_FILE) \
	 $(PLUG1_FILE) $(PLUG2_FILE) $(PLUG3_FILE) \
	 $(ADD_PLUGS)

clean:
	rm -f $(JETTY_FILE) $(IDP_FILE) $(NCSUAD_FILE) $(DUO_FILE) \
		  $(PLUG1_FILE) $(PLUG1_FILE).asc \
		  $(PLUG2_FILE) $(PLUG2_FILE).asc \
		  $(PLUG3_FILE) $(PLUG3_FILE).asc \
		  $(ADD_PLUGS)

$(JETTY_FILE):
	wget -O $(JETTY_FILE) \
		https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-home/$(JETTY_VER)/$(JETTY_FILE)
	echo "$(JETTY_SUM)  $(JETTY_FILE)" | sha256sum -c -

$(IDP_FILE):
	wget -O $(IDP_FILE) \
		https://shibboleth.net/downloads/identity-provider/$(IDP_VER)/$(IDP_FILE)
	echo "$(IDP_SUM)  $(IDP_FILE)" | sha256sum -c -

$(NCSUAD_FILE): /mnt/shib/src/$(NCSUAD_FILE)
	cp -f /mnt/shib/src/$(NCSUAD_FILE) $(NCSUAD_FILE)

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

$(PLUG3_FILE):
	wget -O $(PLUG3_FILE) \
	    https://shibboleth.net/downloads/identity-provider/plugins/scripting/$(PLUG3_VER)/$(PLUG3_FILE)
	wget -O $(PLUG3_FILE).asc \
	    https://shibboleth.net/downloads/identity-provider/plugins/scripting/$(PLUG3_VER)/$(PLUG3_FILE).asc

$(ADD_PLUGS): $(ADD_PLUGS).template
	cat $(ADD_PLUGS).template | \
	    sed -e s/PLUG1VER/$(PLUG1_VER)/ | \
	    sed -e s/PLUG2VER/$(PLUG2_VER)/ | \
	    sed -e s/PLUG3VER/$(PLUG3_VER)/ \
		> $(ADD_PLUGS)
	chmod +x $(ADD_PLUGS)

