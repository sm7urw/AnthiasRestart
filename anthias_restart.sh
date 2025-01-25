# Restart Anthias docker container and send email to user.
# Henrik Korslind
# Version: 1.3

#!/bin/bash

# Loggfil för scriptkörningar
LOGFILE="/home/$USER/anthias_upgrade.log"

# Funktion för att logga med tidsstämpel
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

# Ändra till den angivna katalogen
cd /home/$USER/screenly || { log "Misslyckades med att byta katalog till /home/$USER/screenly"; exit 1; }

# Stäng ner Docker Compose-tjänster och logga resultatet
log "Stänger ner Docker Compose-tjänster..."
if docker compose down; then
    log "Docker Compose-tjänster nedstängda."
else
    log "Fel vid nedstängning av Docker Compose-tjänster."
    exit 1
fi

# Kör upgrade_containers.sh och logga resultatet
log "Kör upgrade_containers.sh..."
if ./bin/upgrade_containers.sh; then
    log "Uppgradering av containrar klar."
else
    log "Fel vid uppgradering av containrar."
    exit 1
fi

# Skicka ett e-postmeddelande via Python och logga resultatet
log "Skickar e-post till användaren..."
if python3 /home/$USER/send_mail.py; then
    log "E-post skickad till användaren."
else
    log "Fel vid e-postskick."
    exit 1
fi

# Skriv ut ett meddelande på skärmen
log "Skriptet slutfört."
echo "Sending email to user"
