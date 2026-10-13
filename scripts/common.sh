#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

ROOT_DIR="${ROOT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
export ROOT_DIR

log()   { echo "[vps-bootstrap] $*"; }
step()  { echo; echo "===== $* ====="; }
run()   { log ">> $*"; "$@"; }

need_root() {
  if [[ "${EUID}" -ne 0 ]]; then
    echo "Este script debe ejecutarse como root (usa sudo)." >&2
    exit 1
  fi
}
