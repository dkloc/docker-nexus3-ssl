#! /bin/bash
if [ ! -e "$NEXUS_DATA/etc/ssl/keystore.jks" ]; then
	mkdir -p "$NEXUS_DATA/etc/ssl"
	chmod go-rwx "$NEXUS_DATA/etc/ssl"
	cd
	cp /mycerts/$MYCERTNAME.p12 ./
	/opt/java/bin/keytool -importkeystore -deststorepass password -destkeypass password -destkeystore keystore.jks -srckeystore $MYCERTNAME.p12 -srcstoretype PKCS12 -srcstorepass $MYCERTPASSWORD -alias jetty
	cp keystore.jks /nexus-data/etc/ssl/
	cd /opt/sonatype/nexus
fi

exec bin/nexus run
