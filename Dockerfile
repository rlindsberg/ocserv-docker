FROM ubuntu:20.04

RUN apt update
RUN apt install ocserv certbot iptables less -y
RUN mkdir -p /etc/ocserv/certs
RUN cd /etc/ocserv/certs
RUN touch /etc/ocserv/ocpasswd

COPY fullchain.pem /etc/ocserv/certs/server-cert.pem
COPY privkey.pem /etc/ocserv/certs/server-key.pem

WORKDIR /etc/ocserv
COPY ocserv.conf /etc/ocserv/ocserv.conf
COPY entrypoint.sh /entrypoint.sh
EXPOSE 443/tcp
EXPOSE 443/udp
ENTRYPOINT ["sh", "/entrypoint.sh"]
CMD ["ocserv", "-c", "/etc/ocserv/ocserv.conf", "-f"]
