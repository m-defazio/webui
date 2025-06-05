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

# Configurazione Docker Compose

Questo progetto utilizza **Docker Compose** per avviare un ambiente composto da tre servizi principali: `open-webui`, `ollama` e `nginx`. Di seguito trovi le istruzioni per l'installazione e l'utilizzo.

## Prerequisiti

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Configurazione

Prima di avviare i servizi, assicurati di avere:

1. Un file `.env` nella root del progetto con la seguente variabile:
    ```
    OPENAI_KEY=<your_openai_key>
    DOMAIN=<your_domain>
    EMAIL=<your_email>
    ```

2. Una cartella `nginx` nella root, contenente le configurazioni nginx e i certificati TLS (se usi HTTPS).

## Avvio dei servizi

Per avviare tutti i servizi, esegui:

```bash
docker-compose up -d
```

Questo comando lancerà i seguenti contenitori:

- **open-webui**: Interfaccia web che si collega a Ollama e OpenAI.
- **ollama**: Backend per i modelli AI.
- **nginx**: Proxy reverso per gestire le connessioni HTTP/HTTPS.

## Dettagli dei Servizi

### open-webui

- Immagine: `ghcr.io/open-webui/open-webui:main`
- Porta: gestita tramite nginx
- Ambiente:
  - `OPENAI_API_KEY`: specificare la chiave API di OpenAI tramite variabile d'ambiente.
  - `OLLAMA_BASE_URL`: URL di collegamento a Ollama (ad esempio, se stai usando Ollama in locale, l'URL predefinita è http://localhost:11434 ).

### ollama

- Immagine: `ollama/ollama:latest`
- Salva i dati persistenti nel volume `ollama-data`.

### nginx

- Immagine: `nginx:alpine`
- Espone le porte `80` (HTTP) e `443` (HTTPS).
- Usa la configurazione da `./nginx` e i certificati da `./nginx/certs`.

## Volumi

- `open-webui-data`: Dati persistenti di open-webui.
- `ollama-data`: Dati persistenti di ollama.

## Reti

- `webui-net`: Rete Docker privata utilizzata dai servizi.

## Comandi Utili

- Avviare i servizi:
  ```bash
  docker-compose up -d
  ```
- Fermare i servizi:
  ```bash
  docker-compose down
  ```
- Visualizzare i log:
  ```bash
  docker-compose logs -f
  ```

## Note

- Assicurati che le porte 80 e 443 non siano occupate da altri servizi sulla tua macchina.
- Modifica le configurazioni nginx se necessario per adattarle alle tue esigenze.
- Per configurare HTTPS, posiziona i certificati nella cartella `./nginx/certs`.
# ✅ Risultato finale
Dopo qualche minuto, accedi a:

https://webui.tuodominio.com
Con HTTPS attivo e certificato valido 🔐<br>
<strong>NOTA: Potrebbe essere necessario ricaricare più volte la pagina o cancellare la cache affinché funzioni.<strong>

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
