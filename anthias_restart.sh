# Restart Anthias coker container.
# Henrik Korslind
# Version: 1.0

#!/bin/bash

# Change directory to the specified path
cd /home/$USER/screenly

# Bring down the Docker Compose services
docker-compose down

# Run the upgrade_containers.sh script
./bin/upgrade_containers.sh

# Send an email notification
echo "Anthias container has restarted." | mail -s "Anthias restarted" email@address.com # Send an email notification
