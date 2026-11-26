#!/bin/bash

dnf install -y git java-25-amazon-corretto-devel

mkdir -p /server
cd /server
git clone https://github.com/Dde1ta/the-minecraft-server.git .

# Ensure Linux line endings and proper permissions for ec2-user
sed -i 's/\r$//' /server/*.sh /server/service/minecraft.service
chmod 755 /server/*.sh
chown -R ec2-user:ec2-user /server

# Install and start the systemd service
mv /server/service/minecraft.service /etc/systemd/system/minecraft.service
systemctl daemon-reload
systemctl enable --now minecraft
