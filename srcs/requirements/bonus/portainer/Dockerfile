FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt install -y curl tar
RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/portainer/portainer/releases/download/2.18.1/portainer-2.18.1-linux-amd64.tar.gz -o portainer.tar.gz \
    && tar -xvzf portainer.tar.gz \
    && mv portainer /usr/local/bin/ \
    && rm portainer.tar.gz

CMD ["/usr/local/bin/portainer/portainer", "--bind", ":9001"]
