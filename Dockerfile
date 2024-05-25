FROM ubuntu:latest
COPY vsftpd-2.3.4 /root/vsftpd-2.3.4
COPY Documents /root/Documents
RUN apt update 
# Install SS for port debugging (ss -tunln to view open ports)
RUN apt install build-essential iproute2 -y
WORKDIR /root/vsftpd-2.3.4
RUN sed -i 's/LINK	=	-Wl,-s/LINK	=	-Wl,-s,-lcrypt/g' Makefile
RUN sed -i '/#define VSF_SYSDEP_HAVE_UTMPX/d' sysdeputil.c
RUN make
RUN cp vsftpd.conf /etc
RUN sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd.conf
RUN sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd.conf
RUN sed -i 's/#local_enable=YES/local_enable=YES/g' /etc/vsftpd.conf
RUN mkdir /var/ftp/
RUN useradd -d /var/ftp ftp
RUN chown root.root /var/ftp
RUN chmod og-w /var/ftp
RUN mkdir /usr/share/empty
RUN ln -s /root/vsftpd-2.3.4/vsftpd /bin/vsftpd
RUN chmod 770 /bin/vsftpd
RUN ln -s /root/vsftpd-2.3.4/start-vsftpd.sh /bin/start-vsftpd
RUN chmod 770 /bin/start-vsftpd
EXPOSE 21/tcp