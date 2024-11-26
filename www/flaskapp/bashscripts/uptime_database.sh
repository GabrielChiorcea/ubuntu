#!/bin/bash


mysqladmin -u root  status | awk '{print $2}' > /var/www/flaskapp/uptime.txt
