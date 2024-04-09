#!/bin/bash

sudo apt-get install -y pipx
sudo apt-get install -y sshpass
pipx ensurepath
pipx install ansible-core

sudo cp -r ../etc /

# Create ssh key
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -N '' <<< $'\ny' >/dev/null 2>&1

# Copy ssh key to nodes
sshpass -p "$NODEPASSWORD" ssh-copy-id -i ~/.ssh/id_rsa.pub pi@node01.local
sshpass -p "$NODEPASSWORD" ssh-copy-id -i ~/.ssh/id_rsa.pub pi@node02.local

# Copy files to nodes
scp -r ../../node/ pi@node01.local:/
scp -r ../../node/ pi@node02.local:/

# Ping nodes using ansible
ansible cube -m ping

# Setup iptables
sshpass -p "$NODEPASSWORD" ansible cube -m apt -a "name=iptables state=present"

# Reboot nodes
sshpass -p "$NODEPASSWORD" ansible workers -b -m shell -a "sudo reboot"
.