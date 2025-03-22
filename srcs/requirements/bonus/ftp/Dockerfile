FROM debian:buster

RUN apt update -y && apt upgrade -y 
RUN apt install -y \
    vsftpd \
    ftp

RUN apt clean && rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/ftp.sh /tmp/ftp.sh

RUN chmod +x /tmp/ftp.sh

CMD [ "/tmp/ftp.sh" ]