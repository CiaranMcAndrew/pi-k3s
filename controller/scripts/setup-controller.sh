sudo apt-get install -y pipx
sudo apt-get install -y sshpass
pipx ensurepath
pipx install ansible-core

cp ../etc /

cd
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -N '' <<< $'\ny' >/dev/null 2>&1
sshpass -p $NODEPASSWORD ssh-copy-id -i ~/.ssh/id_rsa.pub pi@node01.local
ssh-copy-id -i ~/.ssh/id_rsa.pub pi@node02.local
.