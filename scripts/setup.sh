# Update programs
sudo apt update  
sudo apt upgrade -y  

# Extend Memory
sudo dd if=/dev/zero of=/swapfile bs=1M count=4096
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sed -i '$ a /swapfile                                 swap                    swap    defaults        0 0' /etc/fstab

# Install Docker
curl -fsSL https://get.docker.com/ | sh
sudo systemctl enable docker

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo apt install git -y


git clone https://github.com/weseek/growi-docker-compose.git growi
mv growi/docker-compose.yml growi/docker-compose.original.yml
sed -r "s/(^.*)(127\.0\.0\.1:)(3000:3000.*$)/\1\3/g" growi/docker-compose.original.yml > growi/docker-compose.yml

# Check results
diff growi/docker-compose.original.yml growi/docker-compose.yml
free -m

