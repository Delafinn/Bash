#!/bin/bash



#MYSQL CONFIGURATIONS
port="3306"   # port used by mysql

read -p "Enter the server you're wanting to connect to: " xserver
read -p "Enter mysql username: " user_logon
read -sp "Enter mysql password: " logon_pass

mysqlsh --user=$user_logon --password=$logon_pass --host=$xserver --port=$port --sql
