#!/bin/bash

## Display command line arguments
echo "Executing command - ${0}"

# man bash    # Special Parameters
echo "Number of command line arguments - ${#}"
echo "Command line arguments - ${@}"    ### "${@}" == "$1"  "${2}" "$3" ...
echo "Command line arguments - ${*}"    ### "${*}" == "$1c$2c$3..."

NUMBER_OF_ARGS=${#}

if [[ ${NUMBER_OF_ARGS} -lt 1 ]]
then
    echo "Usage: ${0} USERNAME [USERNAME] ..."
    exit 1
fi


### Create own executable file
# echo ${PATH}
# man bash
# which -a head
# sudo cp head.sh /usr/local/bin/head
# sudo chmod +x /usr/local/bin/head
# which -a head
# sudo rm /usr/local/bin/head
# hash
# help hash
# hash -r


### Display Path & Filename of script

# basename /does/not/exist.sh
# dirname /does/not/exist.sh

BASENAME=$(basename $0)
DIRNAME=$(dirname $0)

echo "Basename - ${BASENAME}"
echo "Dirname - ${DIRNAME}"

### For Loop
# type -a for

# for X in John Jenny James
# do
#     echo "Hello ${X}"
# done

# for USERNAME in "${@}"          ## ${*} -> Hello John Jenny James
# do
#     echo "Hello ${USERNAME}"
# done

SPECIAL_CHARACTERS='!@#$%^&*()_+'
for USERNAME in "${@}"
do 
    SPECIAL_CHAR=$(echo ${SPECIAL_CHARACTERS} | fold -w1 | shuf | head -c1) 
    PASSWORD=$(date +%N${RANDOM} | sha256sum | head -c9)${SPECIAL_CHAR}
    echo "Password for ${USERNAME} - ${PASSWORD}"
done

