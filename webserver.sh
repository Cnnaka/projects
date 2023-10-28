#! /bin/bash
# Clone git repo
git clone https://github.com/laravel/laravel

#enter the laravel folder just created
cd laravel

#install dependencies
sudo apt install php-curl curl zip unzip php-xml

#install composer

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
php composer-setup.php --install-dir=projects
sudo mv composer.phar /usr/local/bin/composer

#use composer install to download dependencies
#repo directories
composer install
composer update

mv .env.example .env

#generate key
php artisan key:generate

#disable apache site
a2dissite 000-default.conf
cd /etc/apache2/sites-available


#create .conf file
sudo touch laravel.conf
sudo a2ensite laravel
sudo mkdir -p /var/www/laravel
cd /var/www/laravel
sudo chown -R vagrant:www-data /var/www/laravel/
sudo find /var/www/laravel/ -type f -exec chmod 664 {} \;
sudo find /var/www/laravel/ -type d -exec chmod 775 {} \;
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache


