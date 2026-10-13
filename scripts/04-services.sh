#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
need_root

step "Configurando fail2ban"
install -m 0644 "${ROOT_DIR}/config/fail2ban/jail.local" /etc/fail2ban/jail.local
service fail2ban restart || true

step "Instalando y arrancando Netdata"
apt-get install -y netdata
service netdata start 2>/dev/null || netdata -D >/var/log/netdata-bootstrap.log 2>&1 &
