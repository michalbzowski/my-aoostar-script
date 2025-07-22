sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

dnf install jellyfin

sudo firewall-cmd --zone=FedoraServer --add-port=8096/tcp --permanent
sudo firewall-cmd --add-service=jellyfin --permanent
sudo firewall-cmd --reload
