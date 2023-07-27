#!/bin/bash

# Remove conflicting packages
sudo apt update
sudo apt remove docker docker-engine docker.io containerd runc

# Install pre-requisites
sudo apt install ca-certificates curl gnupg lsb-release

# Add Docker's PPA
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update
sudo apt install docker-compose docker-ce docker-ce-cli containerd.io

# Enable rootless mode
sudo groupadd docker
sudo usermod -aG docker $USER

# Enable Docker daemon
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Reboot
for i in {5..1}
do
  echo -e "\e[41mWARNING: Rebooting in $i seconds! Press CTRL + C to cancel.\e[0m"
  sleep 1s
done
reboot