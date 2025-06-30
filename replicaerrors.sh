#!/bin/bash
#MYSQL CONFIGURATIONS
servers = ("rsp401")

port="3306"  # port used by mysql

# Prompt Admin for credentials
read -p "Enter mysql username: " user_logon
read -sp "Enter mysql password: " logon_pass


# Function to validate replication status on a given server
validate_policy() {
    local server=$1

    validation_output=$(mysqlsh --user=$user_logon --password=$logon_pass --host=$server --port=$port --sql \
        -e "SELECT * FROM performance_schema.replication_applier_status_by_worker\G;")

    if [ $? -eq 0 ]; then
        echo "Replication error for '$server' is:"
        echo "$validation_output"
    else
        echo "Failed to connect on '$server'!"
    fi
}

# Loop through each server listed and check replication
for server in "${servers[@]}"; do
    validate_policy $server
done
