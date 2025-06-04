#!/bin/bash

DOMAIN="webui.micheledefazio.me"
EMAIL="lorenzo@gmail.com" # <-- cambia con la tua
OPENAI_KEY=$(OPENAI_API_KEY)
echo "[+] Aggiornamento pacchetti e installazione prerequisiti..."
apt update && apt install -y docker.io docker-compose nginx certbot python3-certbot-nginx ufw

echo "[+] Abilito e avvio Docker"
systemctl enable docker && systemctl start docker

echo "[+] Creo rete Docker dedicata"
docker network create webui-net || true

echo "[+] Avvio Open WebUI"
docker run -d \
  --name open-webui \
  --network webui-net \
  -e OPENAI_API_KEY=$OPENAI_KEY \
  -p 8080:8080 \
  ghcr.io/open-webui/open-webui:main

echo "[+] Creo configurazione Nginx per il reverse proxy"
cat > /etc/nginx/sites-available/webui <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

ln -sf /etc/nginx/sites-available/webui /etc/nginx/sites-enabled/webui

echo "[+] Testo configurazione Nginx"
nginx -t || { echo "❌ Nginx config non valida"; exit 1; }

echo "[+] Ricarico Nginx"
systemctl reload nginx

echo "[+] Ottengo certificato HTTPS con Certbot"
certbot --nginx --non-interactive --agree-tos --redirect -m $EMAIL -d $DOMAIN

echo "[+] ✅ TUTTO PRONTO! Vai su: https://$DOMAIN"
