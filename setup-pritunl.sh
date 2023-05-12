#!/bin/bash

# Add Pritunl package repository
sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb http://repo.pritunl.com/stable/apt jammy main
EOF

# Import Pritunl signing key from keyserver
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A

# Alternative import from download if keyserver offline
curl https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc | sudo apt-key add -

# Add MongoDB package repository for version 6.0
sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list << EOF
deb https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse
EOF

# Import MongoDB signing key for version 6.0
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

# Update package list
sudo apt update

# Upgrade the system
sudo apt --assume-yes upgrade

# Install WireGuard package and tools
sudo apt -y install wireguard wireguard-tools

# Install Pritunl and MongoDB packages
sudo apt -y install pritunl mongodb-org

# Enable MongoDB and Pritunl services to start at boot
sudo systemctl enable mongod pritunl

# Start MongoDB and Pritunl services
sudo systemctl start mongod pritunl
