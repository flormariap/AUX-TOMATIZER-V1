#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
need_root

step "Eliminando navegadores anteriores (si existen)"
apt-get remove --purge -y firefox chromium chromium-browser 2>/dev/null || true
apt-get autoremove -y 2>/dev/null || true

step "Agregando repositorio oficial de Brave Browser"
install -d -m 0755 /usr/share/keyrings
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

cat > /etc/apt/sources.list.d/brave-browser-release.sources <<'EOF'
Types: deb
URIs: https://brave-browser-apt-release.s3.brave.com/
Suites: stable
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/brave-browser-archive-keyring.gpg
EOF

step "Instalando Brave Browser"
apt-get update
apt-get install -y brave-browser
xdg-settings set default-web-browser brave-browser.desktop 2>/dev/null || true
update-alternatives --set x-www-browser /usr/bin/brave-browser-stable 2>/dev/null || true

echo
echo "Brave instalado: $(brave-browser --version)"
EOF