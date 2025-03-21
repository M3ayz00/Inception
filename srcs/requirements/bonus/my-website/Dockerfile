FROM debian:buster

RUN apt update -y && apt upgrade -y 
RUN apt install -y \
    nginx

COPY ./index.html /var/www/html

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g" , "daemon off;"]