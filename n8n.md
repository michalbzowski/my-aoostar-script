docker volume create n8n_data

docker run -d -it --rm --name n8n -p 5678:5678 -e GENERIC_TIMEZONE="Europe/Warsaw" -e TZ="Europe/Warsaw" -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true -e WEBHOOK_URL="https://automate-n8n.michalbzowski.pl/" -e N8N_RUNNERS_ENABLED=true -e N8N_SECURE_COOKIE=false -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n
