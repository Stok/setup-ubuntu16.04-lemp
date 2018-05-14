#!/bin/bash

# Updating apt-get
sudo apt-get update
sudo apt-get -y dist-upgrade

# Nginx
sudo apt-get -y install nginx
sudo ufw allow 'Nginx HTTP'

# MySQL
sudo apt-get -y install mysql-server

#PHP
sudo apt-get -y install php-fpm php-mysql
cat /etc/php/7.0/fpm/php.ini | sed "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" > ./php.ini
sudo chown root:root ./php.ini
sudo cp ./php.ini /etc/php/7.0/fpm/php.ini
sudo rm ./php.ini
sudo systemctl restart php7.0-fpm

sudo chown root:root ./nginx_sites_available_default
sudo cp ./nginx_sites_available_default /etc/nginx/sites-available/default
sudo nginx -t
sudo systemctl reload nginx

