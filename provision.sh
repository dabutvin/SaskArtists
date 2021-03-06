#! /usr/bin/env bash

###
#
# install_mysql.sh
#
# This script assumes your Vagrantfile has been configured to map the root of
# your application to /vagrant and that your web root is the "public" folder
# (Laravel standard).  Standard and error output is sent to
# /vagrant/vm_build.log during provisioning.
#
###

# Variables
#DBHOST=localhost
DBNAME=compcamps
DBUSER=mentor
DBPASSWD=admin

echo -e "\n--- Updating packages list ---\n"
apt-get -qq update

echo -e "\n--- Upgradig Packages ---\n"
apt-get upgrade -y >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Install base packages ---\n"
apt-get -y install vim curl build-essential python-software-properties git ruby-sass ruby-dev composer >> /vagrant/vm_build.log 2>&1
gem install listen

echo -e "\n--- Updating packages list ---\n"
apt-get -qq update

echo -e "\n--- Enabling mod-rewrite ---\n"
a2enmod rewrite >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Allowing Apache override to all ---\n"
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

echo -e "\n--- Setting document root to vagrant directory ---\n"
rm -rf /var/www/html
ln -fs /vagrant/www/ /var/www/html

echo -e "\n--- We definitly need to see the PHP errors, turning them on ---\n"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/apache2/php.ini

echo -e "\n--- Restarting Apache ---\n"
service apache2 restart >> /vagrant/vm_build.log 2>&1
