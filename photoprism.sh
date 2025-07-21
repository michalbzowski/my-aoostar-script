sudo partprobe /dev/sda
sudo partx -a /dev/sda1
sudo fdisk -l /dev/sda
sudo mkdir -p /mnt/sda

sudo blkid /dev/sda1
sudo vi /etc/fstab
#Dodaj do pliku wpis - uuid z blkid
UUID=e6e75fe2-916c-4441-97fc-602e909b6bce /mnt/sda1 ext4 defaults 0 2
systemctl daemon-reload


sudo mount /dev/sda1 /mnt/sda
sudo blkid /dev/sda1

Następnie dodaj linię w /etc/fstab: 

text
UUID=twoj-uuid /mnt/sda_data ext4 defaults 0 2
Ale utworzenie partycji z web gui utworzyło wpis samo

Podmieniam teraz konfigurację w docker compose, żeby voulmeny wskazywały na /mnt/sda1

sudo mkdir /mnt/sda1/photoprism/pictures
sudo mkdir /mnt/sda1/photoprism/.storage
sudo mkdir ~/.storage
