# Clone repo into machine
echo "Setting up project files..."
cp -r vsftpd-2.3.4/ /root/vsftpd-2.3.4
cp -r Documents/ /root/Documents
echo "Installing Requirements..."
apt update
apt install build-essential iproute2 -y
echo "Let's Setup VSFTPD-2.3.4!"
cd /root/vsftpd-2.3.4
sed -i 's/LINK	=	-Wl,-s/LINK	=	-Wl,-s,-lcrypt/g' Makefile
sed -i '/#define VSF_SYSDEP_HAVE_UTMPX/d' sysdeputil.c
make
cp vsftpd.conf /etc
sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd.conf
sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd.conf
sed -i 's/#local_enable=YES/local_enable=YES/g' /etc/vsftpd.conf
echo "Setting up some environmental stuff"
mkdir /var/ftp/
useradd -d /var/ftp ftp
chown root.root /var/ftp
chmod og-w /var/ftp
mkdir /usr/share/empty
ln -s /root/vsftpd-2.3.4/vsftpd /bin/vsftpd
chmod 770 /bin/vsftpd
ln -s /root/vsftpd-2.3.4/start-vsftpd.sh /bin/start-vsftpd
chmod 770 /bin/start-vsftpd
echo "Cleanup"
rm -r /root/VSFTPD-2.3.4-Exercise-1
echo "Starting VSFTPD!"
start-vsftpd