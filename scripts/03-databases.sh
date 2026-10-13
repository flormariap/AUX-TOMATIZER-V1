#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
need_root

step "Instalando MariaDB, PostgreSQL y Redis"
apt-get install -y \
  mariadb-server mariadb-client \
  postgresql postgresql-contrib \
  redis-server

step "Arrancando bases de datos"
service mariadb start || service mysql start || true
service postgresql start || true
service redis-server start || true
