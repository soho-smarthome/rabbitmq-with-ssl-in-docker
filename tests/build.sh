#!/bin/bash

IMAGE_NAME="rabbitmq-with-ssl-test"

docker build --no-cache=true -t ${IMAGE_NAME} ..
