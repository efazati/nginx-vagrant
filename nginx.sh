#!/bin/bash

useradd -m -s /bin/bash -U user -u 666 --groups wheel
cp -pr /home/vagrant/.ssh /home/user/
echo "%user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

yum update -y
yum install -y epel-release
yum update -y
yum install -y net-tools
yum install -y docker
yum install -y nginx

systemctl restart docker

cp -r /home/vagrant/files /home/user/files 
chown -R user:user /home/user
cp /home/vagrant/files/nginx.conf /etc/nginx/nginx.conf

setfacl -m u:nginx:--x /home/user/
setfacl -m u:nginx:r-x /home/user/files 
setfacl -m u:nginx:r-- /home/user/files/*

setenforce permissive


C=XX
ST=XX
L=XXXXXXXXX
O=XXXXX
OU=XX
HOST=localhost.com
DATE=$(date '+%Y%m%d')
CN=$HOST

# Generate a unique private key (KEY)
sudo openssl genrsa -out "${HOST}.key" 2048

# Generating a Certificate Signing Request (CSR)
sudo openssl req -new -key "${HOST}.key" -out "${HOST}.csr" <<EOF
${C}
${ST}
${L}
${O}
${OU}
${CN}
selfsigned@${CN}
.
.
EOF

mv localhost* /opt

# Creating a Self-Signed Certificate (CRT)
openssl x509 -req -days 365 -in "${HOST}.csr" -signkey "${HOST}.key" -out "${HOST}.crt"

# openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

docker run --rm -d -it -p 8000:80 mendhak/http-https-echo

systemctl enable nginx

systemctl restart nginx
