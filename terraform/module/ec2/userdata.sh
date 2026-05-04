#!/bin/bash

set -eux

dnf update -y

# Install Docker
dnf install -y docker

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

# Install Microsoft Defender
rpm --import https://packages.microsoft.com/keys/microsoft.asc

cat <<EOF > /etc/yum.repos.d/microsoft-prod.repo
[microsoft-prod]
name=Microsoft Production
baseurl=https://packages.microsoft.com/rhel/8/prod/
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

dnf install -y mdatp

systemctl enable mdatp
systemctl start mdatp