#!/bin/bash

CONTAINER_NAME="nginx-server"
NGINX_PORT="80"
CONTAINER_PORT="8080"
NGINX_CONFIG_FILE="/home/skonr/nginx.conf"

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -c|--config)
    NGINX_CONFIG_FILE="$2"
    shift
    shift
    ;;
    -p|--port)
    NGINX_PORT="$2"
    shift
    shift
    ;;
    *)   
    echo "błąd w wyborze $1"
    exit 1
    ;;
esac
done

docker run -d -p $CONTAINER_PORT:$NGINX_PORT -v $NGINX_CONFIG_FILE:/etc/nginx/nginx.conf --name $CONTAINER_NAME nginx


CONTAINER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONTAINER_NAME)
echo "Access the website at: http://$CONTAINER_IP:$NGINX_PORT"
