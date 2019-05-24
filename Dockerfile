#FROM rabbitmq:3.6.16
#FROM rabbitmq:3.6.6-management
FROM rabbitmq:3.6.6-management-alpine
#FROM rabbitmq:3.6.6
RUN apk update && apk add ca-certificates \
        #&& apt-get update \
	&& apk add openssl \ 
	&& mkdir -p /home/testca/certs \
	&& mkdir -p /home/testca/private \
	&& chmod 700 /home/testca/private \
	&& echo 01 > /home/testca/serial \
	&& touch /home/testca/index.txt

COPY rabbitmq.config /etc/rabbitmq/rabbitmq.config
COPY enabled_plugins /etc/rabbitmq/enabled_plugins
COPY openssl.cnf /home/testca
COPY prepare-server.sh generate-client-keys.sh /home/

RUN mkdir -p /home/server \
	&& mkdir -p /home/client \
	&& chmod +x /home/prepare-server.sh /home/generate-client-keys.sh
RUN /home/prepare-server.sh 
	#&& rabbitmq-server restart
         #&& /usr/lib/rabbitmq/bin/rabbitmq-server start

# Define environment variables.
ENV RABBITMQ_USER admin
ENV RABBITMQ_PASSWORD admin
ENV V_HOST int
ADD init.sh /init.sh
RUN ["chmod", "+x", "/init.sh"]

#CMD /bin/bash /home/generate-client-keys.sh && rabbitmq-server && sleep 60 && /bin/bash /init.sh
CMD /bin/bash /home/generate-client-keys.sh && /bin/bash /init.sh
#sleep infinity
