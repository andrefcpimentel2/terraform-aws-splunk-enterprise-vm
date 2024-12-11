#!/usr/bin/env bash
set -x

echo "==> Base"


echo "--> Installing common dependencies"
sudo apt-get update
apt-get install -y \
  build-essential \
  cpu-checker \
  nodejs \
  curl \
  emacs \
  git \
  jq \
  tmux \
  unzip \
  vim \
  wget \
  tree \
  qemu-kvm \
  virt-manager \
  virtinst \
  libvirt-clients \
  bridge-utils \
  libvirt-daemon-system \
  apt-transport-https \
  curl \
  &>/dev/null


echo "==> Install Docker"

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 

echo "==> Run Splunk Container"

sudo docker pull splunk/splunk:latest

# Docker permission
sudo usermod -a -G docker $USER
newgrp docker

sudo docker run -d -p 8000:8000 -p 8088:8088  -p 8089:8089 -e SPLUNK_START_ARGS='--accept-license' -e SPLUNK_PASSWORD='${password}' splunk/splunk:latest

