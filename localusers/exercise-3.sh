#!/bin/bash

## Check if you are root
if [[ "${UID}" -ne 0 ]]
then
    echo "You are not root. You don't have previledge to create new user" >&2
    exit 1
fi

## check if number of arguments is greater than 1
if [[ "${#}" -lt 1 ]]
then
    echo "Usage: ${0} USERNAME [COMMENT] ..." >&2
    exit 1
fi

## fetch username & comment
USERNAME=${1}
shift 1
COMMENT=${*}

## Generate random password
SPECIAL_CHARACTERS="!@#$%^&*()_+"
SPECIAL_CHAR=$(echo ${SPECIAL_CHARACTERS} | fold -w1 | shuf | head -c1)
PASSWORD=$(date +%N${RANDOM} | sha256sum| head -c7)${SPECIAL_CHAR}

## Add New user
useradd -c "${COMMENT}" -m ${USERNAME} >& /dev/null

if [[ ${?} -ne 0 ]]
then
    echo "Account could not be created" >&2
    exit 1
fi

## Set Password for new user
echo ${PASSWORD} | passwd --stdin ${USERNAME} >& /dev/null

if [[ ${?} -ne 0 ]]
then
    echo "Password could not be set" >&2
    exit 1
fi

## Expire password for new user
passwd -e ${USERNAME} >& /dev/null

if [[ ${?} -ne 0 ]]
then
    echo "Password could not be expired" >&2
    exit 1
fi

## Display User Details
echo "host - $(hostname) : Created user - ${USERNAME} with password - ${PASSWORD} & comment - ${COMMENT}"

## switch to new user
# su -l ${USERNAME}

## Delete user
# sudo userdel -r ${USERNAME}

exit 0