#!/bin/bash

if [ $UID -ne 0 ]
then
	echo -e "\033[0;31mRun as sudo\033[0m"
	exit
fi

apt install -y docker.io

wget https://download.virtualbox.org/virtualbox/6.1.40/virtualbox-6.1_6.1.40-154048~Debian~bullseye_amd64.deb -O vbox.deb

dpkg -i vbox.deb
apt install --fix-broken -y

mkdir ~/.ssh

usermod -a -G vboxusers iot
usermod -a -G docker iot

echo "* 0.0.0.0/0 ::/0" >> /etc/vbox/networks.conf

rm vbox.deb
