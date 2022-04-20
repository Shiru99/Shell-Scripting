#!/bin/bash

## Print UID
echo "Your UID - ${UID}"

## Display if UID != 1000
TESTING_UID=1000

if [[ "${UID}" -ne "${TESTING_UID}" ]]
then
    echo "Your UID doesnot match with ${TESTING_UID}"
    exit 1
fi

## Display username
USERNAME=$(id -un)
# USERNAME=$(id -unx)

## Check if `id -un` command was successful
if [[ "${?}" -ne 0 ]]       ## ? exit status for earlier command (here for id -un)
then
    echo "Error: unable to get username"
    exit 1
fi

TESTING_USERNAME="vagrant"
if [[ ${USERNAME} != ${TESTING_USERNAME} ]]
then 
    echo "Your username doesn't match with ${TESTING_USERNAME}"
    exit 1
fi

echo "Your username - ${USERNAME}"
exit 0
