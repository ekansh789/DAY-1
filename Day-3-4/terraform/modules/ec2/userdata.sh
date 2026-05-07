#!/bin/bash

set -eux

dnf update -y

# Install Docker
dnf install -y docker

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

dnf update -y

# Create Docker CLI plugin directory
mkdir -p /usr/local/lib/docker/cli-plugins

# Download latest Docker Compose v2 binary
wget https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -O /usr/local/lib/docker/cli-plugins/docker-compose

# Make Docker Compose executable
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Verify installation
docker compose version

# Install Microsoft Defender
#!/bin/bash

# Update packages
dnf update -y

# Install DNF plugins
dnf install -y dnf-plugins-core

# Import Microsoft GPG key
rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Add Microsoft repository for Amazon Linux 2023 / RHEL9
cat <<EOF > /etc/yum.repos.d/microsoft-prod.repo
[packages-microsoft-com-prod]
name=packages-microsoft-com-prod
baseurl=https://packages.microsoft.com/rhel/9/prod/
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

# Clean and rebuild DNF cache
dnf clean all
dnf makecache

# Install Microsoft Defender for Endpoint (MDATP)
dnf install -y mdatp

# Enable and start service
systemctl enable mdatp
systemctl start mdatp

# Verify service status
systemctl status mdatp --no-pager