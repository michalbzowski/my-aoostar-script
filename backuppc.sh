#Install BackupPC - based on blog https://ipv6.rs/tutorial/Fedora_Server_Latest/BackupPC/
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf -y install backuppc

sudo firewall-cmd --add-service=http --permanent 
sudo firewall-cmd --reload

sudo vi /etc/httpd/conf.d/BackupPC.conf
#1 add "Require valid-user"  instead "Require local"
#2 rename AuthName "BackupPC" to AuthName "backuppc"

sudo htpasswd -c /etc/BackupPC/apache.users backuppc

sudo vi /etc/BackupPC/config.pl
#EDIT TO $Conf{TopDir} = '/sda/BackupPC';
#EDIT TO $Conf{CgiAdminUsers}  = 'backuppc';

sudo mkdir -p /var/run/BackupPC
sudo chown backuppc:backuppc /var/run/BackupPC

sudo systemctl restart httpd 
sudo systemctl restart backuppc
