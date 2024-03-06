#!/bin/bash
sudo su
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "<html> <h1> Hello world from WEB_SERVER </h1> </html>" > /var/www/html/index.html