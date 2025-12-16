docker volume create n8n_data

docker run -d -it --rm --name n8n -p 5678:5678 -e GENERIC_TIMEZONE="Europe/Warsaw" -e TZ="Europe/Warsaw" -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true -e WEBHOOK_URL="https://automate-n8n.michalbzowski.pl/" -e N8N_RUNNERS_ENABLED=true -e N8N_SECURE_COOKIE=false -e EXECUTIONS_DATA_PRUNE=true -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n


//Nowe podejście do sprawdzenia - dockerfile z pythonem:
FROM n8nio/n8n

# Switch to root to install packages
USER root

# Install Python and required build tools
RUN apk add --no-cache \
    python3 \
    py3-pip

# Upgrade pip
RUN pip3 install --no-cache --upgrade pip

# Install required Python packages
RUN pip3 install --no-cache-dir \
    gkeepapi

# Create directory for shared files
RUN mkdir -p /shared

# Switch back to node user
USER node

# Set working directory
WORKDIR /home/node/.n8n

# Expose port
EXPOSE 5678

# Start n8n
CMD ["n8n"]


//koniec dockerfile

Zapisz plik jako Dockerfile.

Utwórz obraz Docker:

bash
docker build -t n8n-python .
Uruchom kontener z volume:

bash
docker run -d -it --rm --name n8n -p 5678:5678 \
  -e GENERIC_TIMEZONE="Europe/Warsaw" \
  -e TZ="Europe/Warsaw" \
  -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
  -e WEBHOOK_URL="https://automate-n8n.michalbzowski.pl/" \
  -e N8N_RUNNERS_ENABLED=true \
  -e N8N_SECURE_COOKIE=false \
  -e EXECUTIONS_DATA_PRUNE=true \
  -v n8n_data:/home/node/.n8n \
  -v /path/to/shared:/shared \
  n8n-python
Uwagi
/path/to/shared to ścieżka na host, gdzie będą zapisywane pliki.

W skrypcie Python możesz zapisywać pliki do /shared.

W ten sposób uruchomisz n8n z Pythonem i dostępem do zapisywania plików na dysku.
