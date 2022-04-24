#!/bin/bash

SERVER_FILE='/vagrant/servers'

# echo "192.168.56.11 server1" | sudo tee -a /etc/hosts
# echo "192.168.56.12 server2" | sudo tee -a /etc/hosts

echo 'server1' > "${SERVER_FILE}"
echo 'server2' >> "${SERVER_FILE}"

if [[ ${UID} -eq 0 ]]
then
    echo "Do not execute this script as root.  Use the -s option instead." >&2
    exit 1
fi


usage() {
  echo "Usage: ${0} [-nsv] [-f FILE] COMMAND"  
  echo 'Executes COMMAND as a single command on every server.'
  echo '  -f FILE  Use FILE for the list of servers. Default: /vagrant/servers.'
  echo '  -n       Dry run mode.  Display the COMMAND that would have been executed and exit.'
  echo '  -s       Execute the COMMAND using sudo on the remote server.'
  echo '  -v       Verbose mode. Displays the server name before executing COMMAND.'
  exit 1
}

log(){
    local MESSAGE=${*}
    if [[ -n "${MESSAGE}" &&  -n "${VERBOSE}" ]]
    then
        echo "${MESSAGE}"
    fi
}


SUDO=''
VERBOSE=''
while getopts snvf: OPTION
do
    case ${OPTION} in
        s)
            SUDO="sudo"
            log "Sudo is enabled"
            ;;
        n)
            DRY_RUN="True"
            log "Dry run is enabled"
            ;;
        v)
            VERBOSE="v"
            log "Verbose is enabled"
            ;;
        f)
            SERVER_FILE=${OPTARG}
            log "Set servers from - ${SERVER_FILE}" 
            ;;
        ?)
            echo "Invalid option"
            usage
            ;;
    esac
done

if [[ ! -e "${SERVER_FILE}" ]]
then 
    echo "Cannot open ${SERVER_FILE}" >&2
    exit 1
    usage
fi

shift "$(( OPTIND - 1 ))"

if [[ ${#} -lt 1 ]]
then
    usage
fi

COMMAND=${*}
EXIT_STATUS=0

for SERVER in $(cat ${SERVER_FILE})
do  
    if [[ -n "${DRY_RUN}" ]]
    then
        echo "DRY RUN: " ssh -"${VERBOSE}"o ConnectTimeout=2 "${SERVER}" "set -o pipefail;  ${SUDO} ${COMMAND}"
    else
        ssh -"${VERBOSE}"o ConnectTimeout=2 "${SERVER}" "set -o pipefail; ${SUDO} ${COMMAND}"
        SSH_EXIT_STATUS="${?}"
        if [[ "${SSH_EXIT_STATUS}" -ne 0 ]]
        then
            EXIT_STATUS="${SSH_EXIT_STATUS}"
            echo "${SERVER} responded with some error. please check with -v option"
        fi
        echo
    fi
done


rm "${SERVER_FILE}"

exit "${EXIT_STATUS}"

