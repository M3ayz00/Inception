FROM debian:buster

RUN apt update -y && apt upgrade -y 
RUN apt install -y \
    adminer
RUN apt clean && rm -rf /var/lib/apt/lists/*



CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd.conf"]