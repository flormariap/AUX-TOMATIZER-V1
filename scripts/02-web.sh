#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
need_root

step "Instalando Nginx + Apache + PHP 8.3"
apt-get install -y \
  nginx \
  apache2 libapache2-mod-php \
  php-fpm php-cli php-mysql php-pgsql php-sqlite3 php-curl php-gd \
  php-mbstring php-xml php-zip php-bcmath php-intl php-redis

step "Configurando Apache en 8081 (evitar conflicto con Nginx)"
sed -i 's/^Listen 80$/Listen 8081/' /etc/apache2/ports.conf
sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8081>/' /etc/apache2/sites-available/000-default.conf
a2enmod php8.3 authz_core authz_host rewrite >/dev/null 2>&1 || true

step "Arrancando servicios web"
service nginx start || true
service php8.3-fpm start || service php-fpm start || true
service apache2 restart || service apache2 start || true
