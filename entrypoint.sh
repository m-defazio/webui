#!/bin/sh

# Avvia il server Ollama in background
echo "[+] Avvio ollama serve in background..."
ollama serve &

# Attendi che il server sia pronto
until ollama list > /dev/null 2>&1; do
  sleep 2
done

# Scarica i modelli
MODELS="deepseek-r1:1.5b"
echo "[+] Scarico modelli: $MODELS"
for model in $MODELS; do
    echo "[+] Pulling $model..."
    ollama pull "$model" || true
done

# Resta in foreground per tenere il container vivo
echo "[+] Ollama pronto, server attivo!"
wait
