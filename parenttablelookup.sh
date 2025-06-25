#!/bin/bash
# MYSQL CONFIGURATIONS

port="3306"  # MySQL port

# Prompt Admin for credentials
read -p "Enter the server you're wanting to connect to: " xserver
read -p "Enter MySQL username: " user_logon
read -sp "Enter MySQL password: " logon_pass
read -p "Enter parent table name to search for: " xtarget

# Define server list (if you want to support multiple later)
servers=("$xserver")

# Function to check foreign key relationships on a given server
validate_policy() {
    local server=$1

    validation_output=$(mysqlsh --user="$user_logon" --password="$logon_pass" --host="$server" --port="$port" --sql \
        -e "SELECT table_schema, table_name, column_name, constraint_name 
            FROM information_schema.key_column_usage 
            WHERE referenced_table_name = '$xtarget';")

    if [ $? -eq 0 ]; then
        echo -e "\nForeign key references to '$xtarget' on '$server':"
        echo "$validation_output"
    else
        echo -e "\n❌ Failed to query '$server'!"
    fi
}

# Loop through each server listed (currently just one)
for server in "${servers[@]}"; do
    validate_policy "$server"
done
