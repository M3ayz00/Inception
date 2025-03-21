FROM debian:buster

RUN apt update -y && apt upgrade -y 
RUN apt install -y \
    vsftpd
RUN apt clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/wordpress /var/run/vsftpd/empty
RUN useradd -m -d /var/www/wordpress ftpuser -s /bin/bash && \
    echo 'ftpuser:password' | chpasswd

RUN usermod -aG www-data ftpuser

COPY conf/vsftpd.conf /etc/vsftpd.conf

RUN chown -R ftpuser:ftpuser /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress

CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd.conf"]