#! /bin/bash
if [ ! -e "$NEXUS_DATA/etc/ssl/keystore.jks" ]; then
	mkdir -p "$NEXUS_DATA/etc/ssl"
	chmod go-rwx "$NEXUS_DATA/etc/ssl"
	#/opt/java/bin/keytool -keystore "$NEXUS_DATA/etc/ssl/keystore.jks" \
	#-alias jetty -genkey -keyalg RSA -sigalg SHA256withRSA \
	#-validity 1095 -storepass password -keypass password \
	#-ext BC:true=ca:true \
	#-dname "cn=$HOST"
	cd
	cp /mycerts/devbox.p12 ./
	/opt/java/bin/keytool -importkeystore -deststorepass password -destkeypass password -destkeystore keystore.jks -srckeystore devbox.p12 -srcstoretype PKCS12 -srcstorepass test -alias jetty
	cp keystore.jks /nexus-data/etc/ssl/
	cd /opt/sonatype/nexus
fi

exec bin/nexus run
