#!/bin/bash

# echo "hello from exercise-2"

## Check if you are root
if [[ "${UID}" -ne 0 ]]
then
    echo "You are not root. You don't have previledge to create new user"
    exit 1
fi

if [[ "${#}" -lt 2 ]]
then
    echo "Usage: ${0} USERNAME [COMMENT] ..."
    exit 1
fi

USERNAME=${1}
shift 1
COMMENT=${*}

# echo "Creating user - ${USERNAME} with comment - ${COMMENT}"


SPECIAL_CHARACTERS="!@#$%^&*()_+"
SPECIAL_CHAR=$(echo ${SPECIAL_CHARACTERS} | fold -w1 | shuf | head -c1)
PASSWORD=$(date +%N${RANDOM} | sha256sum| head -c7)${SPECIAL_CHAR}

## Creating new user
useradd -c "${COMMENT}" -m ${USERNAME}

if [[ ${?} -ne 0 ]]
then
    echo "Account could not be created"
    exit 1
fi

## Set password for new user
echo ${PASSWORD} | passwd --stdin ${USERNAME}

## Expire password for new user
passwd -e ${USERNAME}

echo "Created user - ${USERNAME} with password - ${PASSWORD} & comment - ${COMMENT}"
echo "on host - $(hostname)"
echo

## switch to new user
# su -l ${USERNAME}

## Delete user
# sudo userdel -r ${USERNAME}

exit 0
