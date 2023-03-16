#!/bin/bash

CONTAINER_NAME="nginx-server"
NGINX_PORT="80"
CONTAINER_PORT="8080"
DEFAULT_HTML="<html><body><h1>stepik3 zadanie1 test</h1></body></html>"

docker run -d -p $CONTAINER_PORT:$NGINX_PORT --name $CONTAINER_NAME nginx

if [ $# -eq 0 ]; then
  echo "$DEFAULT_HTML" | docker exec -i $CONTAINER_NAME bash -c 'cat > /usr/share/nginx/html/index.html'
else
  if [ -f "$1" ]; then
    docker cp "$1" $CONTAINER_NAME:/usr/share/nginx/html/index.html
  else
    echo "File not found!"
    exit 1
  fi
fi

CONTAINER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONTAINER_NAME)
echo "Access the website at: http://$CONTAINER_IP:$NGINX_PORT"
