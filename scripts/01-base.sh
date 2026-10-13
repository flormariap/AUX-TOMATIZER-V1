#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
need_root

step "Actualizando índices de paquetes"
apt-get update

step "Instalando herramientas base y seguridad"
apt-get install -y \
  build-essential software-properties-common \
  apt-transport-https ca-certificates curl wget git unzip zip tar rsync \
  net-tools iputils-ping dnsutils htop tmux screen nano vim jq tree lsof sysstat \
  rsyslog \
  ufw fail2ban \
  certbot python3-certbot-nginx \
  supervisor

step "Arrancando rsyslog (para auth.log)"
rsyslogd 2>/dev/null || true
