sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker mbzowski
sudo ln -s /run/docker.sock /var/run/docker.sock
sudo systemctl enable --now docker
sudo systemctl start docker
