#!/bin/bash

mkdir -p /var/cache/nginx
chown nginx:nginx /var/cache/nginx

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/certs/nginx.key \
    -out /etc/nginx/certs/nginx.crt \
    -subj "/CN=localhost"

cat > /etc/nginx/conf.d/default.conf <<EOF
server {
    listen       80;
    server_name  localhost;

    location / {
        proxy_pass http://localhost:3000;
    }

    proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=my_cache:10m inactive=60m;
    proxy_cache_key "\$scheme\$request_method\$host\$request_uri";
    proxy_cache_valid 200 60m;
}

server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate /etc/nginx/certs/nginx.crt;
    ssl_certificate_key /etc/nginx/certs/nginx.key;

    location / {
        proxy_pass http://localhost:3000;
    }

    proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=my_cache:10m inactive=60m;
    proxy_cache_key "\$scheme\$request_method\$host\$request_uri";
    proxy_cache_valid 200 60m;
}
EOF

docker run -d \
  --name zadanie3 \
  -p 80:80 \
  -p 443:443 \
  -v /var/cache/nginx:/var/cache/nginx \
  -v /etc/nginx/conf.d/default.conf:/etc/nginx/conf.d/default.conf \
  nginx

docker run -d \
  --name node-zadanie3 \
  -v /server:/app \
  -w /app \
  node npm start
