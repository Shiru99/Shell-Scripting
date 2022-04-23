#!/bin/bash

if [[ ${UID} -ne 0 ]]
then
    echo "You are not root. You don't have previledge to delete existing user" >&2
    exit 1
fi


usage() {
  echo "Usage: ${0} [-dav] -n NAME"  
  echo 'Generate a random password.'
  echo '  -n NAME   Specify account name.'
  echo '  -d        Deletes accounts.'
  echo '  -a        Archive Account.'
  echo '  -v        Verbose'
  exit 1
}

log(){
    local MESSAGE=${*}
    if [[ -n "${MESSAGE}" &&  -n "${VERBOSE}" ]]
    then
        echo "${MESSAGE}"
    fi
}

DELETE="False"
ARCHIVE="False"

while getopts davn: OPTION
do
    case ${OPTION} in
        d)
            DELETE="True"
            log "Set Account to Delete"
            ;;
        a)
            ARCHIVE="True"
            log "Set Account to Archive"
            ;;
        v)
            VERBOSE="v"
            log "Verbose is enabled"
            ;;
        n)
            NAME=${OPTARG}
            log "Set Account name to ${NAME}" 
            ;;
        ?)
            echo "Invalid option"
            usage
            ;;
    esac
done

if [[ ${#} -lt 1 ]]
then
    usage
fi

shift "$(( OPTIND - 1 ))"

if [[ ${#} -gt 0 ]]
then
    usage
fi

sudo ./exercise-3.sh James James Doe

USER_ID=$(id -u "${NAME}")

if [[ ${USER_ID} -lt 1000 ]]
then
    log "User ${NAME} - Researved system accounts can't be disabled or deleted"
    exit 1
fi

ARCHIVE_DIR="/archives"

if [[ "${ARCHIVE}" = "True" ]]
then 
    if [[ ! -d "${ARCHIVE_DIR}" ]]
    then 
        log "Creating ${ARCHIVE_DIR} directory"
        mkdir -p ${ARCHIVE_DIR}
    fi

    log "Archieving account..."
    sudo tar -zc"${VERBOSE}"f ${ARCHIVE_DIR}/archive-${NAME}.tar.gz /home/${NAME}/

    if [[ ${?} -ne 0 ]] 
    then
        log "Unable to Archieve account"
    fi
fi



if [[ "${DELETE}" = "True" ]]
then
    log "Deleting account..."
    sudo userdel -r ${NAME}

    if [[ ${?} -ne 0 ]] 
    then
        echo "Unable to Delete account"
    else 
        echo "Successfully, Deleted an account for ${NAME}"
    fi
else 
    log "Disabling account..."
    sudo chage -E 0 ${NAME}
    if [[ ${?} -ne 0 ]] 
    then
        echo "Unable to Delete account"
    else 
        echo "Successfully, Disabled an account for ${NAME}"
    fi
fi


