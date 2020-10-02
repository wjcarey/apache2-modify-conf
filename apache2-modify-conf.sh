#!/bin/bash

#APACHE2 & PHP MODIFY CONFIG
echo "enabling rewrite, expires, and headers modules to apache ..."
a2enmod rewrite expires headers
echo "updating rewrite rules to apache config ..."
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
echo "silencing apache server tokens from server ..."
printf "\n#Remove Server Tokens\nServerTokens Prod\n#Remove server signature\nServerSignature Off" >> /etc/apache2/apache2.conf
echo "updating php config with higher memory and upload size ..."
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 1G/g;s/post_max_size = 8M/post_max_size = 1G/g;s/memory_limit = 128M/memory_limit = 512M/g;s/max_execution_time = 30/max_execution_time = 300/g;s/max_input_time = 60/max_input_time = 300/g;' /etc/php/7.4/apache2/php.ini
echo "restarting apache2 ..."
systemctl restart apache2
echo "success: configuration complete ..."

rm -- "$0"
exit