#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ROOT_DIR

source "${ROOT_DIR}/scripts/common.sh"
need_root

step "Iniciando bootstrap VPS"

bash "${ROOT_DIR}/scripts/01-base.sh"
bash "${ROOT_DIR}/scripts/02-web.sh"
bash "${ROOT_DIR}/scripts/03-databases.sh"
bash "${ROOT_DIR}/scripts/04-services.sh"
bash "${ROOT_DIR}/scripts/05-node-nvm.sh"
bash "${ROOT_DIR}/scripts/06-opencode.sh"
bash "${ROOT_DIR}/scripts/07-omnirush.sh"

step "Bootstrap completado"
echo "Resumen de puertos:"
echo "  Nginx:      80"
echo "  Apache:     8081"
echo "  MariaDB:    3306"
echo "  PostgreSQL: 5432"
echo "  Redis:      6379"
echo "  SSH:        2222 (en este contenedor)"
echo
echo "Revisa /root/VPS_INFO.md o la salida anterior para detalles."
