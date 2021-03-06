#!/bin/bash
(sleep 5 ; \
rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASSWORD ; \
rabbitmqctl set_user_tags $RABBITMQ_USER administrator ; \
rabbitmqctl add_vhost $V_HOST; \
rabbitmqctl set_permissions -p $V_HOST $RABBITMQ_USER ".*" ".*" ".*" ; \
echo "*** User '$RABBITMQ_USER' with password '$RABBITMQ_PASSWORD' completed. ***") &
rabbitmq-server $@
