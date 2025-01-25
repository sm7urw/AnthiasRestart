# Stop, update and restart Anthias docker container and send email to user while creating log entry.
# Henrik Korslind
# Version: 1.5

#!/bin/bash

# Logfile for script
LOGFILE="/home/$USER/anthias_upgrade.log"

# Function for addning time and date to log entry
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOGFILE
}

# Change directory
cd /home/$USER/screenly || { log "Failed to change dir to /home/$USER/screenly"; exit 1; }

# Shut down Docker Compose-service and log the result
log "Shutting down the Docker Compose service..."
if docker compose down; then
    log "Docker Compose service shut down."
else
    log "Error while shutting down Docker Compose service."
    exit 1
fi

# Run upgrade_containers.sh and log the result
log "Running upgrade_containers.sh..."
if ./bin/upgrade_containers.sh; then
    log "Update container finished."
else
    log "Error while updating container."
    exit 1
fi

# Send email via Python and write result to logfile
log "Sending e-mail to user..."
if python3 /home/$USER/send_mail.py; then
    log "E-mail sent to user."
else
    log "Error while sending e-mail."
    exit 1
fi

# Write message on screen
log "Script finished."
echo "Sending email to user"
