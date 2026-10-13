#!/usr/bin/env bash
set -euo pipefail
# Carga NVM si está disponible
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
# shellcheck disable=SC1091
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"

step() { echo; echo "===== $* ====="; }
step "Instalando OpenCode"
curl -fsSL https://opencode.ai/v2/install | bash
