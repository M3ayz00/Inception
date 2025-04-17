FROM debian:bullseye

RUN apt update -y && apt upgrade -y 
RUN apt install -y \
    nginx
RUN apt clean && rm -rf /var/lib/apt/lists/*

COPY conf/index.html /var/www/html/my-website/

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g" , "daemon off;"]