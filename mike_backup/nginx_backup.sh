#!/bin/bash
DATE=$(date +%F)
mkdir -p ~/backup/output
tar -czf ~/backup/output/nginx_backup_$DATE.tar.gz /etc/nginx/ /usr/share/nginx/html/
tar -tzf ~/backup/output/nginx_backup_$DATE.tar.gz > ~/backup/output/nginx_verify_$DATE.log

