#! /bin/bash
yum update -y
yum install -y httpd

# changing default port to given port number
sed -i "s/Listen 80/Listen ${APP_PORT_NO}/" /etc/httpd/conf/httpd.conf

echo "Hello from Auto-Scaling EC2" > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd