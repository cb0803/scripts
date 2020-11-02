#!/bin/bash
apt-get -y update
apt-get -y upgrade
apt-get -y install sshpass apache2 php php-mysql mysql-server zip unzip

mysql -e "create database client;"
mysql -e "create user 'client'@'localhost' identified with mysql_native_password by '';"
mysql -e "grant all privileges on client.* to 'client'@'localhost';"
mysql -e "flush privileges;"

ssh-keyscan -H 10.106.0.2 >> ~/.ssh/known_hosts
sshpass -p "" scp root@10.106.0.2:/root/backup.sh /root

chmod +x /root/backup.sh

{ crontab -l -u root; echo '0 */6 * * * /root/backup.sh'; } | crontab -u root -
