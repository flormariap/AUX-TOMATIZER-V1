#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
need_root

step "Instalando entorno de escritorio (XFCE) + VNC + noVNC"
apt-get install -y \
  xfce4 xfce4-goodies tigervnc-standalone-server novnc websockify xterm dbus-x11

VNC_DISPLAY="${VNC_DISPLAY:-:1}"
VNC_GEOMETRY="${VNC_GEOMETRY:-1920x1080}"
VNC_DEPTH="${VNC_DEPTH:-24}"
VNC_PASSWORD="${VNC_PASSWORD:-desktop123}"

step "Configurando contraseña VNC"
mkdir -p /root/.vnc
printf '%s\n%s\nn\n' "$VNC_PASSWORD" "$VNC_PASSWORD" | vncpasswd

cat > /root/.vnc/xstartup <<'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
[ -r "$HOME/.Xresources" ] && xrdb "$HOME/.Xresources"
exec startxfce4
EOF
chmod +x /root/.vnc/xstartup

VNC_PORT=5901
NOVNC_PORT=6080

if ! ss -tlnp | grep -q ":${VNC_PORT} "; then
  step "Arrancando servidor VNC en display ${VNC_DISPLAY}"
  rm -f /tmp/.X11-unix/X1 /tmp/.X*-lock
  vncserver "$VNC_DISPLAY" -geometry "$VNC_GEOMETRY" -depth "$VNC_DEPTH" -localhost no
else
  log "VNC ya está en ejecución en el puerto ${VNC_PORT}"
fi

if ! ss -tlnp | grep -q ":${NOVNC_PORT} "; then
  step "Arrancando noVNC en el puerto ${NOVNC_PORT}"
  websockify -D --web=/usr/share/novnc "0.0.0.0:${NOVNC_PORT}" "localhost:${VNC_PORT}" >/var/log/novnc-bootstrap.log 2>&1 || true
else
  log "noVNC ya está en ejecución en el puerto ${NOVNC_PORT}"
fi

echo
echo "Escritorio disponible:"
echo "  VNC directo: 127.0.0.1:${VNC_PORT}  (password: ${VNC_PASSWORD})"
echo "  noVNC (navegador): http://127.0.0.1:${NOVNC_PORT}/vnc.html?host=127.0.0.1&port=${NOVNC_PORT}"
echo
echo "Si accedes por túnel SSH, mapea el puerto ${NOVNC_PORT}."