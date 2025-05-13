#!/bin/bash
DATE=$(date +%F)
mkdir -p ~/backup/output
tar -czf ~/backup/output/apache_backup_$DATE.tar.gz /etc/apache2/ /var/www/html/
tar -tzf ~/backup/output/apache_backup_$DATE.tar.gz > ~/backup/output/apache_verify_$DATE.log
