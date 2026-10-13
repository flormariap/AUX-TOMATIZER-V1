#!/usr/bin/env bash
set -euo pipefail
# Carga NVM si está disponible
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
# shellcheck disable=SC1091
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"

step() { echo; echo "===== $* ====="; }
step "Instalando omnirush (global)"
npm i -g omnirush@latest
