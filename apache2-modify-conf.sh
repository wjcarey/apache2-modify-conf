#!/bin/bash

#APACHE2 & PHP MODIFY CONFIG
echo "enabling rewrite, expires, headers modules to apache ..."
a2enmod rewrite expires headers
echo "enabling rewrite rules to apache directory ..."
sed -i '0,/AllowOverride None/s//AllowOverride All/; 2,/AllowOverride None/s//AllowOverride All/; 0,/Require all denied/s//Require all granted/' /etc/apache2/apache2.conf
echo "silencing apache server tokens from server ..."
printf "\n#Remove Server Tokens\nServerTokens Prod\n#Remove server signature\nServerSignature Off" >> /etc/apache2/apache2.conf
echo "updating php.ini for higher memory and upload size ..."
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 1G/g;s/post_max_size = 8M/post_max_size = 1G/g;s/memory_limit = 128M/memory_limit = 512M/g;s/max_execution_time = 30/max_execution_time = 300/g;s/max_input_time = 60/max_input_time = 300/g;' /etc/php/7.4/apache2/php.ini
echo "restarting apache2 ..."
systemctl restart apache2

rm -- "$0"
exit