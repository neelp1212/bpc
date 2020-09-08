FROM alpine:3.7

ENV JAVA_HOME /usr/lib/jvm/default-jvm/jre

COPY holodeck holodeck
COPY config/init.sh holodeck/bin/
COPY config/setWSPort.xsl holodeck/bin
COPY config/setReceiver.xsl holodeck/bin

RUN ["apk", "update"]
RUN ["apk", "add", "bash"]
RUN /sbin/apk update && /sbin/apk add libxslt openjdk8 && \
	/bin/mkdir /var/lib/holodeck && \
	/bin/chmod 750 holodeck/bin/init.sh
RUN ["holodeck/bin/init.sh"]

VOLUME holodeck/conf
VOLUME holodeck/data
VOLUME /var/lib/holodeck

ENV AXIS_PORT 8080

EXPOSE 8080

ENTRYPOINT ["holodeck/bin/startServer.sh"]

CMD []

# mkdir holodeck/conf/pmodes
