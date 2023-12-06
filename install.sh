#!/usr/bin/env bash

apt update
mkdir -p /var/www/ocserv
chown www-data:www-data /var/www/ocserv -R
