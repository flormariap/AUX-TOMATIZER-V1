#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
need_root

step "Descargando e instalando NVM v0.40.8"
# Download and install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash

# in lieu of restarting the shell
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
# shellcheck disable=SC1091
\. "$NVM_DIR/nvm.sh"

step "Descargando e instalando Node.js 24"
# Download and install Node.js
nvm install 24

# Set default
nvm alias default 24
nvm use 24

step "Verificando versiones"
# Verify the Node.js version: should print v24.21.0
node -v
# Verify npm version: should print 11.19.0
npm -v
