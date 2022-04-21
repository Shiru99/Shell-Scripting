#!/bin/bash

echo "Your user ID - ${UID}"

## Ask for username 
read -p "Enter username: " USERNAME         # Conventionally max 8 chars long

## Ask for real name
read -p "Enter user's full name: " COMMENT

## Ask for password
read -p "Enter password: " PASSWORD

## Create new user
useradd -c "${COMMENT}" -m ${USERNAME}

## Set password
echo ${PASSWORD} | passwd --stdin ${USERNAME}

## Set password expiration to force password change
passwd -e ${USERNAME}


