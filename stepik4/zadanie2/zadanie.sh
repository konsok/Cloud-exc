#!/bin/bash

docker volume create nodejs_data

docker run -d --name nodejs-container -v nodejs_data:/app node

docker volume create all_volumes

docker run --rm -v nginx_data:/from -v all_volumes:/to busybox cp -a /from/. /to/

docker run --rm -v nodejs_data:/from -v all_volumes:/to busybox cp -a /from/. /to/
