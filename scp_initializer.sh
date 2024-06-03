#!/bin/bash

# Script to SCP Automations over to a remote host.

# Variables (adjust these as needed)
AUTOMATION_LOCATION="/Path/to/script/scriptname.sh"


# Function to print status
print_status() {
  printf "\n\e[1;32m$1\e[0m\n"
}

# Confirmation function
Confirmation() {
read -p "Is that correct?" REPLY
if [$REPLY = "no"] || [$REPLY = "n"] || [$REPLY = "N"] || [$REPLY = "NO"]; then
  exit 1
else
  echo "Moving forward!"
fi
}

read -p "Enter the hostname to scp the automation to." HOST_NAME

printf "the host we are going to scp over to: $HOST_NAME"

Confirmation

read -p "Enter your username" USER_NAME

print_status "Beginning SCP...."

scp $AUTOMATION_LOCATION $USER_NAME@$HOST_NAME:

print_status "SCP COMPLETED..."



printf "Copy this: ssh $USER_NAME@$HOST_NAME \n And begin automation on specified host. \n"
