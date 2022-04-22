#!/bin/bash

### getopts ###

: '
    script tp generate password with options
    
        -l : Length of password (default 48)
        -s : Include special characters
        -v : Enable verbose mode (default off)
'

usage() {
  echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
  echo 'Generate a random password.' >&2
  echo '  -l LENGTH  Specify the password length.' >&2
  echo '  -s         Append a special character to the password.' >&2
  echo '  -v         Increase verbosity.' >&2
  exit 1
}

log(){
    local MESSAGE=${*}
    if [[ -n "${MESSAGE}" && "${VERBOSE}" = 'True' ]]
    then
        echo "${MESSAGE}"
    fi

    # logger -t "${0}" "${MESSAGE}" 
}

LENGTH=48
VERBOSE="False"

while getopts vl:s OPTION           ## 'l:' - l requires an argument
do
    case ${OPTION} in
        v)
            VERBOSE="True"
            log "Verbose mode is on"
            ;;
        l)
            LENGTH=${OPTARG}
            log "Length is ${LENGTH}" 
            ;;
        s)
            SPECIAL="True"
            log "Special characters are included"
            ;;
        ?)
            echo "Invalid option" >&2 
            usage
            ;;
    esac
done


## Remove the options while leaving the remaining arguments.
# All the args are passed to the script
# echo "Number of args: ${#}"
# echo "All args: ${@}"

# OPTIND - index of the next arg to be processed
# echo "OPTIND: ${OPTIND}"
shift "$(( OPTIND - 1 ))"

# All the args are passed to the script
# echo "Number of args: ${#}"
# echo "All args: ${@}"

if [[ ${#} -gt 0 ]]
then
    usage
fi


log "generating a password..."


if [[ ${SPECIAL} = "True" ]]
then
    SPECIAL_CHARACTERS="!@#$%^&*()_+"
    SPECIAL_CHAR=$(echo ${SPECIAL_CHARACTERS} | fold -w1 | shuf | head -c1)
    PASSWORD=$(date +%N${RANDOM} | sha256sum| head -c$((${LENGTH} - 1)))${SPECIAL_CHAR}
else
    PASSWORD=$(date +%N${RANDOM} | sha256sum| head -c${LENGTH})
fi

log "done"
echo "generated password - ${PASSWORD}"
