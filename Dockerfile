FROM sonatype/nexus3:3.3.1

ENV MYCERTNAME=mycertname
ENV MYCERTPASSWORD=mycertpassword

USER root

RUN chown -R nexus:nexus ${NEXUS_HOME}/etc \
&& sed '/^application-port/s:$:\napplication-port-ssl=8443:' -i ${NEXUS_HOME}/etc/nexus-default.properties \
&& sed '/^nexus-args/s:$:,${jetty.etc}/jetty-https.xml:' -i ${NEXUS_HOME}/etc/nexus-default.properties \
&& rm -rf ${NEXUS_HOME}/etc/ssl && ln -s ${NEXUS_DATA}/etc/ssl ${NEXUS_HOME}/etc/ssl

COPY start.sh /usr/local/bin

USER nexus

# nexus webinterface
EXPOSE 8443
# port that will be used for the docker registry group
EXPOSE 8444
# port that will be used for pushing to the private docker registry
EXPOSE 8445

CMD start.sh
