#!/bin/bash
#MYSQL CONFIGURATIONS
servers = ("servername1" "servername2")

port="3306"  # port used by mysql

# Prompt Admin for credentials
read -p "Enter mysql username: " user_logon
read -sp "Enter mysql password: " logon_pass


# Function to validate replication status on a given server
validate_policy() {
    local server=$1

    validation_output=$(mysqlsh --user=$user_logon --password=$logon_pass --host=$server --port=$port --sql \
        -e "SHOW BINARY LOGS;")

    if [ $? -eq 0 ]; then
        echo "Binary logs for '$server' are:"
        echo "$validation_output"
    else
        echo "Failed to connect '$server'!"
    fi
}

# Loop through each server listed and check replication
for server in "${servers[@]}"; do
    validate_policy $server
done
