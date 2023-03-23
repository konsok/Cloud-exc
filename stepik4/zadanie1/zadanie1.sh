#!/bin/bash

docker volume create stepik4zad1_data

echo "Hello World" > /var/lib/docker/volumes/stepik4zad1_data/_data/index.html

docker run -d -p 8080:80 -v stepik4zad1_data:/usr/share/nginx/html --name stepik4zad1 nginx

curl http://localhost:8080/