#!/bin/bash

## Check if user is root
if [[ "${UID}" -ne 0 ]]
then
    echo "You are not root. You don't have previledge to create new user"
    exit 1
fi

## Ask for username
read -p "Enter username: " USERNAME

## Ask for full name
read -p "Enter user's full name: " COMMENT

## Ask for password
read -p "Enter password: " PASSWORD

## Create new user
useradd -c "${COMMENT}" -m ${USERNAME}

## Informs the user if the account was not able to be created
STATUS=${?}
if [[ ${STATUS} -ne 0 ]]
then
    echo "Account could not be created"
    exit 1
fi

## Set password for new user
echo ${PASSWORD} | passwd --stdin ${USERNAME}

## Set password expiration to force password change
passwd -e ${USERNAME}

HOSTNAME=$(hostname)
## Display 
echo "Your username is ${USERNAME}"
echo "Your password is ${PASSWORD}"
echo "Current Hostname is ${HOSTNAME}"
exit 0

## switch to new user
# su -l ${USERNAME}

## Delete user
# userdel -r ${USERNAME}