#!/bin/bash

# Variables (adjust these as needed)
# SERVICE_NAME="mysql"
# BACKUP_DIR="/path/to/backup"
# MYSQL_USER="root"
# MYSQL_PASS="your_password"



# Function to print status
print_status() {
  printf "\n\e[1;32m$1\e[0m\n"
}

# Confirmation function
Confirmation() {
read -p "Want to continue?" REPLY
if [$REPLY = "no"] || [$REPLY = "n"] || [$REPLY = "N"]; then
  exit 1
else
  echo "Moving forward!"
fi
}

print_status "Running template!"

Confirmation
