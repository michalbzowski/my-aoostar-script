sudo partprobe /dev/sda
sudo partx -a /dev/sda1
sudo fdisk -l /dev/sda
sudo mkdir -p /mnt/sda

sudo blkid /dev/sda1
sudo vi /etc/fstab
#Dodaj do pliku wpis - uuid z blkid
UUID=ab983751-a221-4d08-ae36-0f7b78ca5b5f /mnt/sda ext4 defaults 0 2
systemctl daemon-reload




sudo mount /dev/sda1 /mnt/sda
sudo blkid /dev/sda1

Następnie dodaj linię w /etc/fstab:

text
UUID=twoj-uuid /mnt/sda_data ext4 defaults 0 2


