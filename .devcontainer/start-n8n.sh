#!/usr/bin/env bash
set -e

URL="https://${CODESPACE_NAME}-5678.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}/"
DATA_DIR="$(pwd)/n8n_data"

mkdir -p "$DATA_DIR"
chmod 777 "$DATA_DIR"

docker rm -f n8n >/dev/null 2>&1 || true

docker run -d --name n8n --restart unless-stopped -p 5678:5678 \
  -e GENERIC_TIMEZONE=America/Mexico_City \
  -e TZ=America/Mexico_City \
  -e WEBHOOK_URL="$URL" \
  -e N8N_EDITOR_BASE_URL="$URL" \
  -e N8N_PROXY_HOPS=1 \
  -v "$DATA_DIR":/home/node/.n8n \
  docker.n8n.io/n8nio/n8n

echo ""
echo "============================================================"
echo " n8n está arrancando (tarda unos 30 segundos)."
echo " 1. Abre la pestaña PORTS, clic derecho en 5678:"
echo "    Port Visibility -> Public"
echo " 2. Abre esta dirección en el navegador:"
echo "    $URL"
echo "============================================================"
