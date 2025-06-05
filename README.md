# 🧠 Open WebUI + Ollama + Nginx

Un'infrastruttura completa per utilizzare [Open WebUI](https://github.com/open-webui/open-webui) con modelli LLM locali tramite [Ollama](https://ollama.com), con supporto per OpenAI API e Nginx come reverse proxy.

> ✅ Il container è preconfigurato per scaricare automaticamente il modello `deepseek-r1:1.5b`.

---

## 🚀 Avvio rapido

### Clona il repository:

```bash
git clone https://github.com/m-defazio/webui.git
cd webui
```

### Crea un file `.env` con la tua API Key di OpenAI (facoltativa):

```bash
echo "OPENAI_KEY=sk-xxxxx..." > .env
```

### Avvia l'infrastruttura:

```bash
docker compose up -d
```

### Accedi all’interfaccia Web:

Apri il browser e vai su 👉 [http://localhost](http://localhost)

---

## 🗂 Struttura del progetto

```bash
.
├── docker-compose.yml      # Gestione dei container
├── Dockerfile              # Estende l'immagine Ollama con entrypoint personalizzato
├── entrypoint.sh           # Script per avvio Ollama e download modelli
├── nginx/
│   ├── default.conf        # Configurazione Nginx (personalizzabile)
│   └── certs/              # Certificati TLS (opzionali)
└── .env                    # File con la variabile OPENAI_KEY (non incluso nel repo)
```
---

## 🧠 Modello incluso

Il sistema è preconfigurato per scaricare automaticamente:

- `deepseek-r1:1.5b` – modello leggero e ottimizzato per l'esecuzione locale

Puoi modificare il modello cambiando la riga nel file `entrypoint.sh`.

---

## 🔧 Personalizzazioni

### ✏️ Cambiare il modello LLM

Nel file `entrypoint.sh`, modifica questa riga:

```sh
MODELS="deepseek-r1:1.5b"
```
Sostituiscila con qualsiasi modello disponibile su [https://ollama.com/library](https://ollama.com/library), ad esempio:

```sh
MODELS="llama2:7b"
```
Poi ricostruisci e riavvia:

```bash
docker compose build ollama
docker compose up -d
```
---

## 🌐 Accesso ai servizi

| Servizio     | Porta | URL                    |
|--------------|-------|------------------------|
| Open WebUI   | 443   | https://localhost      |
| Ollama API   | 11434 | http://localhost:11434 |

---

## 🔐 HTTPS (opzionale)

Se vuoi abilitare HTTPS:

1. Aggiungi i certificati `.crt` e `.key` nella cartella `nginx/certs`
2. Modifica il file `nginx/default.conf` per gestire le richieste HTTPS

---

## 🛑 Stop & Pulizia

### Ferma tutti i container:

```bash
docker compose down
```
### Elimina anche volumi e immagini:

```bash
docker compose down -v --rmi all
```
---

## 📃 Licenza

Distribuito sotto licenza **MIT**.

---

## 🙌 Crediti

- [Open WebUI](https://github.com/open-webui/open-webui)
- [Ollama](https://ollama.com)
- [DeepSeek](https://huggingface.co/deepseek-ai)
