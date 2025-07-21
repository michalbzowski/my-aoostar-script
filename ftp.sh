sudo dnf update -y
sudo dnf install vsftpd -y
sudo systemctl start vsftpd
sudo systemctl enable vsftpd

#cat > /etc/vsftpd/vsftpd.conf<< EOF
listen=YES
local_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
pam_service_name=vsftpd

# Allow local user to upload files
write_enable=YES

# Enable Anonymous user to read files (no password, no username)
anonymous_enable=YES
anon_root=/var/ftp
no_anon_password=YES
chroot_local_user=YES
#EOF

sudo adduser ftpuser
sudo passwd ftpuser

sudo mkdir /home/ftpuser/files
sudo chown ftpuser:ftpuser /home/ftpuser
sudo chmod 700 /home/ftpuser
chmod a-w /home/ftpuser

sudo chown ftpuser:ftpuser /home/ftpuser/files

sudo systemctl restart vsftpd


sudo firewall-cmd --zone=FedoraServer --add-port=21/tcp --permanent
sudo firewall-cmd --add-service=ftp --permanent
sudo firewall-cmd --reload
sudo systemctl enable vsftpd
sudo systemctl restart vsftpd
