#!/bin/bash
(sleep 5 ; \
rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASSWORD ; \
sleep 2; \
rabbitmqctl set_user_tags $RABBITMQ_USER administrator ; \
sleep 1; \
rabbitmqctl add_vhost $V_HOST; \
sleep 1; \
rabbitmqctl set_permissions -p $V_HOST $RABBITMQ_USER ".*" ".*" ".*" ; \
echo "*** User '$RABBITMQ_USER' with password '$RABBITMQ_PASSWORD' completed. ***") &
rabbitmq-server $@
