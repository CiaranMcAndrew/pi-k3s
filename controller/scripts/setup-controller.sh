#!/bin/bash

# Define defautl options
NODES=2

while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--nodes)
      NODES="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

sudo apt-get install -y pipx
sudo apt-get install -y sshpass
pipx ensurepath
pipx install ansible-core

sudo cp -r ../etc /

# Create ssh key
echo "Generating ssh key"
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -N '' <<< $'\ny' >/dev/null 2>&1

# Copy ssh key to nodes
for i in $(seq 1 "$NODES"); 
    do {
        node=$(printf 'node%02d\n' "$i")
        echo "Copying ssh key to node: $NAME"
        sshpass -p "$NODEPASSWORD" ssh-copy-id -i ~/.ssh/id_rsa.pub "pi@$NAME.local"
     } || {
        echo "Node: $NAME not available"
    }
done

# Copy files to nodes
#scp -r ../../node/ pi@node01.local:/
#scp -r ../../node/ pi@node02.local:/


echo "Running ansible setup"
# Ping nodes using ansible
ansible cube -m ping

# Setup iptables
sshpass -p "$NODEPASSWORD" ansible cube -m apt -a "name=iptables state=present ignore_unreachable=true"

# Reboot nodes
sshpass -p "$NODEPASSWORD" ansible workers -b -m shell -a "sudo reboot"
.