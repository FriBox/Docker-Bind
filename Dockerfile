FROM ubuntu:22.04

MAINTAINER Stream.Wang <FriBox@Outlook.com>
LABEL version="1.00"
LABEL description="Bind and Webmin Service Docker image from FriBox customization."

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8 \ 
 TZ=Asia/Shanghai \ 
 WEBMIN_VERSION=1.994

ENV ROOT_PASSWORD="pass"

#ADD webmin_1.994_all.deb /webmin_1.994_all.deb
ADD  entrypoint.sh /entrypoint.sh

RUN echo root:pass | chpasswd && \
 echo "Acquire::GzipIndexes \"false\"; Acquire::CompressionTypes::Order:: \"gz\";" >/etc/apt/apt.conf.d/docker-gzip-indexes && \
 sed -i s/archive.ubuntu.com/ftp.sjtu.edu.cn/g /etc/apt/sources.list && \
 sed -i s/security.ubuntu.com/ftp.sjtu.edu.cn/g /etc/apt/sources.list && \
 apt update && \
 apt -y upgrade && \
 apt -y dist-upgrade && \
 apt -y install ntp ntpdate net-tools iputils-ping wget python2 && \
 apt -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions unzip locales && \
 apt -y install libglib2.0-0 libglib2.0-data libicu70 libxml2 shared-mime-info xdg-user-dirs && \
 apt -y install bind9 bind9-host dnsutils && \
 dpkg-reconfigure locales && \
 locale-gen C.UTF-8 && \
 /usr/sbin/update-locale LANG=C.UTF-8 && \
 wget -e "http_proxy=http://192.168.100.253:6004" http://prdownloads.sourceforge.net/webadmin/webmin_1.994_all.deb && \
 dpkg --install webmin_1.994_all.deb && \
 apt -y install -f  && \
 apt -y autoclean && \
 apt -y autoremove && \
 apt -y autoremove --purge && \
 apt -y clean  && \
 rm -rf  webmin_1.994_all.deb  && \
 chmod 755 /entrypoint.sh  && \
 chmod +x /entrypoint.sh  && \
 echo "" 

ENV LC_ALL C.UTF-8

EXPOSE 10000/tcp 53/tcp 53/udp

VOLUME ["/etc/bind"]

#ENTRYPOINT ["echo"," <-- [ FriBox - Bind and Webmin Service ] --> "]
CMD /entrypoint.sh && /usr/sbin/service named restart && /usr/bin/touch /var/webmin/miniserv.log && /usr/sbin/service webmin restart && /usr/bin/tail -f /var/webmin/miniserv.log
