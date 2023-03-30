FROM ubuntu:latest as build

RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update && apt-get install -y nodejs

COPY . /app

WORKDIR /app
RUN npm install

RUN npm run build

FROM nginx:latest

COPY --from=build /app/dist /skonr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]


