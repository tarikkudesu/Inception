#!/bin/bash

mkdir -p /var/run/vsftpd/empty

cat <<EOF > /etc/vsftpd.conf
listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
pasv_enable=YES
pasv_address=10.13.100.205
pasv_min_port=30000
pasv_max_port=30009
user_sub_token=rick
local_root=/var/www/html
secure_chroot_dir=/var/run/vsftpd/empty
EOF

useradd -m -d /var/www/html "$INCEPTION_FTP_USER"
echo "$INCEPTION_FTP_USER:$INCEPTION_FTP_PASS" | chpasswd
chown -R "$INCEPTION_FTP_USER:$INCEPTION_FTP_USER" /var/www

exec /usr/sbin/vsftpd /etc/vsftpd.conf
