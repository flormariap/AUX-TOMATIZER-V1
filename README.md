# VPS Bootstrap

Scripts para instalar automáticamente todo el stack VPS (Ubuntu 22.04/24.04):

- Tools base (build-essential, git, curl, tmux, htop, etc.)
- Nginx + Apache (PHP 8.3)
- MariaDB + PostgreSQL + Redis
- Python 3 (pip/venv)
- fail2ban + rsyslog
- Certbot (Nginx)
- Netdata
- Node.js LTS vía NVM (v24.21.0)
- OpenCode (`curl -fsSL https://opencode.ai/v2/install | bash`)
- omnirush (`npm i -g omnirush@latest`)

## Uso rápido

```bash
git clone <TU-REPO>
cd vps-bootstrap
sudo bash install.sh
```

En entornos sin systemd (contenedores), los scripts arrancan los servicios manualmente.

## Estructura

- `install.sh`: orquestador principal.
- `scripts/`: pasos modulares (incluye `08-desktop.sh` para entorno XFCE + VNC/noVNC opcional).
- `config/`: configuraciones base.
