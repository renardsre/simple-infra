#!/bin/bash

if [[ $(cat /etc/os-release  | grep -i id | cut -d'=' -f2 | awk 'NR==1' | tr -d '"') == "ubuntu" ]]; then

  cd /home/ubuntu

  if [[ $(whoami) == "root" ]]; then
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    usermod -aG docker ubuntu
    systemctl enable docker
    systemctl start docker
  else
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo usermod -aG docker ubuntu
    sudo systemctl enable docker
    sudo systemctl start docker
  fi

fi

if [[ $(cat /etc/os-release  | grep -i id | cut -d'=' -f2 | awk 'NR==1' | tr -d '"') == "amzn" ]]; then

  cd /home/ec2-user

  if [[ $(whoami) == "root" ]]; then
    amazon-linux-extras install -y docker
    curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    usermod -aG docker ec2-user
    systemctl enable docker
    systemctl start docker
  else
    sudo amazon-linux-extras install -y docker
    sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo usermod -aG docker ec2-user
    sudo systemctl enable docker
    sudo systemctl start docker
  fi

fi
