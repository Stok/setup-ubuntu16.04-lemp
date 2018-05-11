#!/bin/bash

# Updating apt-get
sudo apt-get update
sudo apt-get -y dist-upgrade

# Nginx
sudo apt-get install nginx
sudo ufw allow 'Nginx HTTP'

# MySQL
sudo apt-get install mysql-server

#PHP
sudo apt-get install php-fpm php-mysql
sudo cat /etc/php/7.0/fpm/php.ini | sed "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" > /etc/php/7.0/fpm/php.ini
sudo systemctl restart php7.0-fpm

# Configure nginx so it uses PHP
ip=ifconfig eth0 | grep "inet adr" | cut -d ':' -f 2 | cut -d ' ' -f 1
cat ./nginx_sites_available_default | sed "s/server_name _;/server_name $ip;/g" > ./nginx_sites_available_default
sudo chown root ./nginx_sites_available_default
sudo cp ./nginx_sites_available_default /etc/nginx/sites-available/default
sudo nginx -t
sudo systemctl reload nginx

