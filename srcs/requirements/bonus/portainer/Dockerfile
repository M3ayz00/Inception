FROM debian:buster

RUN apt-get update && apt-get install -y curl tar

RUN curl -L https://github.com/portainer/portainer/releases/download/2.18.1/portainer-2.18.1-linux-amd64.tar.gz -o portainer.tar.gz \
    && tar -xvzf portainer.tar.gz \
    && mv portainer /usr/local/bin/ \
    && rm portainer.tar.gz

RUN chmod +x /usr/local/bin/portainer/portainer

CMD ["/usr/local/bin/portainer/portainer", "--host", "tcp://0.0.0.0:9001"]
