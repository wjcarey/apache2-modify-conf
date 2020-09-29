#!/bin/bash

#ADDITIONAL APACHE MODS
a2enmod rewrite expires headers

#ALLOW SYMBOLIC LINK APACHE
sed -i '0,/AllowOverride None/s//AllowOverride All/; 2,/AllowOverride None/s//AllowOverride All/; 0,/Require all denied/s//Require all granted/' /etc/apache2/apache2.conf

#REMOVE APACHE SECURITY HEADERS FROM SERVER
printf "\n#Remove Server Tokens\nServerTokens Prod\n#Remove server signature\nServerSignature Off" >> /etc/apache2/apache2.conf

#UPDATE PHP SETTINGS
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 1G/g;s/post_max_size = 8M/post_max_size = 1G/g;s/memory_limit = 128M/memory_limit = 512M/g;s/max_execution_time = 30/max_execution_time = 300/g;s/max_input_time = 60/max_input_time = 300/g;' /etc/php/7.4/apache2/php.ini

#RELOAD APPACHE SOFTWARE
systemctl restart apache2