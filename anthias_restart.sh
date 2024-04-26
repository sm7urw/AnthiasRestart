# Restart Anthias doker container.
# Henrik Korslind
# Version: 1.1

#!/bin/bash

# Change directory to the specified path
cd /home/$USER/screenly

# Bring down the Docker Compose services
docker-compose down

# Run the upgrade_containers.sh script
./bin/upgrade_containers.sh

# Send an email notification via Python
python3 /home/$USER/send_mail.py
