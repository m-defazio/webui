# 🚀 Open WebUI Setup Script (HTTPS + NGINX + Docker)

Uno script completo per installare [Open WebUI](https://github.com/open-webui/open-webui) su una macchina Ubuntu (es. DigitalOcean), con:

- ✅ Docker + Docker Compose  
- 🌐 Nginx come reverse proxy  
- 🔒 HTTPS con Certbot (Let's Encrypt)  
- 🔑 Chiave API OpenAI tramite `.env` o variabile  
- 📦 Rete Docker dedicata  

---

## 📋 Requisiti

- Un server Ubuntu (consigliato: DigitalOcean, Hetzner, ecc.)
- Un **dominio valido** (es. `webui.tuodominio.com`)
- Il dominio deve puntare all'IP del server
- Una chiave API OpenAI valida

---

## ⚙️ Configura lo script

Modifica le prime variabili nello script `setup-webui.sh`:


DOMAIN="webui.tuodominio.com"         # Cambia con il tuo dominio
EMAIL="tu@email.com"                  # Email per Let's Encrypt
OPENAI_KEY="la_tua_openai_api_key"    # Chiave segreta di OpenAI
🧪 Esempio


DOMAIN="webui.micheledefazio.me"
EMAIL="lorenzo@gmail.com"
OPENAI_KEY="sk-xxxxxxxxxxxxxxxxxxxxxxxx"
🛠️ Esecuzione

Rendi eseguibile lo script:

chmod +x setup-webui.sh
Lancialo come root o con sudo:


sudo ./setup-webui.sh
# ✅ Risultato finale
Dopo qualche minuto, accedi a:

https://webui.tuodominio.com
Con HTTPS attivo e certificato valido 🔐

# 📦 Cosa fa lo script
Installa Docker, Docker Compose, Nginx e Certbot

Avvia il container di Open WebUI

Configura Nginx come reverse proxy sulla porta 443

Ottiene il certificato HTTPS automatico con Let's Encrypt

Crea una rete Docker dedicata

# 📁 File e cartelle generate
Percorso	Contenuto
/etc/nginx/sites-available/webui	Config Nginx per il proxy
/etc/letsencrypt/	Certificati HTTPS Let's Encrypt
docker network ls	Rete webui-net per il container
docker ps	Container open-webui attivo sulla porta 8080

# 📌 Nota finale
Puoi passare la chiave OpenAI anche da un file .env usando:


--env-file .env
E assicurandoti che il file contenga:


OPENAI_API_KEY=sk-xxxxx...
