#!/bin/bash

#### Case statements ####

STAGE="unknown"

# if [[ ${STAGE} = "START" ]]
# then
#     echo "Stage is START"
# elif [[ ${STAGE} = "FINISH" ]]
# then
#     echo "Stage is FINISH"
# else
#     echo "Stage is unknown"
# fi

case ${STAGE} in
    START)
        echo "Stage is START"
        ;;
    FINISH)
        echo "Stage is FINISH"
        ;;
    RESTART|REBOOT|REINSTALL|RERUN)
        echo "Stage is ${STAGE}"
        ;;
    *)
        echo "Stage is unknown"
        ;;
esac



#### Functions ####

: '
    Function need to be declare before using it
    local - local variable in function
'

# function hello {
#     echo "Hello from function hello"
# }

# hello

hello(){
    local MESSAGE=${@}

    ## Sending message to STDOUT
    if [[ -n ${MESSAGE} ]]
    then 
        echo "Greetings from ${MESSAGE}"
    else
        echo "Greetings from ${0} program"
    fi

    ## Sending message to syslog
    if [[ ${VERBOSE} = 'True' ]]
    then
        # echo "Collecting all logs"
        logger -t "${0}" "Collecting all logs from hello func" 
    fi
}

# hello
# VERBOSE='False'          ## Global variable
# readonly VERBOSE
# hello

readonly VERBOSE="True"   ## ReadOnly - Can't be write
# hello abc and xyz


### logger

# type -a logger
# man logger
# logger -t "${0}" "Greetings.!"        ## -t : tag
# sudo tail -3 /var/log/messages 


log(){
    local MESSAGE=${@}
    if [[ -n ${MESSAGE} ]]
    then 
        echo "${MESSAGE}"
    fi

    logger -t "${0}" "${MESSAGE}" 
}

backup_file(){
    local FILE="${1}"

    if [[ -e ${FILE} ]]
    then 
        local BACKUP_FILE="/var/tmp/$(basename ${FILE})-$(date +%F-%N)" 

        log "Backing up ${FILE} to ${BACKUP_FILE}"
        ## Copy file
        cp -p ${FILE} ${BACKUP_FILE}  ## -p : preserve=mode,ownership,timestamps
    else
        echo "File does not exist"
        return 1        ## For functions - return; exit will exit program
    fi
}

backup_status(){
    if [[ ${?} -eq 0 ]]
    then    
        echo "File backup successful"
    else
        echo "File backup failed"
    fi

}

# backup_file '/etc/passwd'
# backup_status

# sudo tail -3 /var/log/messages
# ls -l /var/tmp