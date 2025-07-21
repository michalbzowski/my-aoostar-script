sudo parted /dev/sda
mklabel gpt
mkpart primary ext4 0% 100%
print
quit
