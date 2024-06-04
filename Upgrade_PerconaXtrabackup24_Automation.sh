#!/bin/bash

# Variables (adjust these as needed)
#SERVICE_NAME="mysql"
#MYSQL_USER="root"
#MYSQL_PASS="your_password"
 DESIRED_XVERSION="percona-xtrabackup-24.x86_64"
 
# Function to print status
print_status() {
  printf "\n\e[1;32m$1\e[0m\n"
}
 
# Install function
 install_function() {
 read -p "does percona-xtrabackup-24.x86_64 appear above?" REPLY
if [$REPLY = "no"] || [$REPLY = "n"] || [$REPLY = "N"]; then
  echo "You will need to manually enable and install percona-xtrabackup-24.x86_64" 
  exit 1
else 
  echo "Installing percona-xtrabackup-24" 
  sudo yum install percona-xtrabackup-24.x86_64 
fi
}
 
 
# MAIN 

print_status "Checking MySQL Version...."
CHECK_XVERSION=$(sudo yum list installed | grep percona-xtrabackup)

if echo "$CHECK_XVERSION" | grep -q "$DESIRED_XVERSION"; then
  print_status "Desired version is installed. \n Please check the size of the volume where you are going to run your backup." 
  printf "$CHECK_XVERSION is the version that is desired."
 
elif [ "$CHECK_XVERSION" != "$DESIRED_XVERSION" ]; then
  printf "Versions do not match! \n Removing other version." 
  sudo yum remove $CHECK_XVERSION 
  printf "$CHECK_XVERSION has been removed... " 
  print_status "Beginning the install of percona-xtrabackup-24.x86_64" 
  CHECK_FOR_VERSION=$(sudo yum list available |grep percona-xtrabackup-24.x86_64) 
  echo $CHECK_FOR_VERSION 
  install_function 
  echo "Please check the size of the volume where you are going to run your backup."
fi
