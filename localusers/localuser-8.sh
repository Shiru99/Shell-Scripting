#!/bin/bash

FILE="./temp"

### Redirect STDOUT to a file
echo "First Line" > ${FILE}
cat ${FILE}
echo

### Redirect STDOUT to a file [OVERWRITTING]
echo "New Line" > ${FILE}
cat ${FILE}
echo

### Redirect STDOUT to a file [APPENDING]
echo "Next Line" >> ${FILE}
cat ${FILE}
echo

### Redirect STDIN to a command
read DATA < ${FILE}
echo "Data read from file - ${DATA}"
echo


### STDERROR
# head -n1 /etc/passwd /etc/hosts
# head -1 /etc/passwd /etc/hosts /does/not/exist.sh > ${FILE}
# cat ${FILE}



: '
    File Descriptors : file descriptor is a number that is used to identify a file.

            0 - STDIN
            1 - STDOUT
            2 - STDERR
'

read CENTOS_VERSION 0< /etc/centos-release       ## 0 -> STDIN default for '<'
echo "CentOS Version - ${CENTOS_VERSION}"        ## No space bet '<' and '0'
echo 

echo "Hello" 1> ${FILE}             ## 1 -> STDOUT default for '>'
cat ${FILE}
echo

ERRORFILE="./error"
head -n1 /etc/passwd /etc/hosts /does/not/exist.sh > ${FILE} 2>> ${ERRORFILE}

echo "STDOUT"
cat ${FILE}
echo

echo "STDERR"
cat ${ERRORFILE}
echo

## M-1 : Adding both STDOUT & STDERR in same file
# head -n1 /etc/passwd /etc/hosts /does/not/exist.sh 1> ${FILE} 2>&1   ## No space bet > and &
# cat ${FILE}                                 ## 2>&1 -> STDERR redirected as STDOUT
# echo

## M-2 :
# head -n1 /etc/passwd /etc/hosts /does/not/exist.sh &> ${FILE}
# cat ${FILE} 
# echo

# echo "Hello
# Hi
# Bye" | cat -n     ## number all output lines

# head -n1 /etc/passwd /etc/hosts /does/not/exist.sh | cat -n         ## counts only STDOUT
# head -n1 /etc/passwd /etc/hosts /does/not/exist.sh 2>&1 | cat -n    ## counts STDOUT & STDERR
# head -n1 /etc/passwd /etc/hosts /does/not/exist.sh |& cat -n        ## counts STDOUT & STDERR


## Adding STDOUT to STDERR (USECASE: To add error)
echo "This fake STDERR!" >&2
echo "${?}"
echo

## Send STDOUT or STDERR to null device
# head -n1 /etc/passwd /etc/hosts /does/not/exist.sh > /dev/null    ## Discard STDOUT
# head -n1 /etc/passwd /etc/hosts /does/not/exist.sh 2> /dev/null   ## Discard STDERR
head -n1 /etc/passwd /etc/hosts /does/not/exist.sh >& /dev/null     ## Discard STDOUT & STDERR
## USECASE - just to see if it works
echo "${?}"
echo

## Delete file
rm ${FILE} ${ERRORFILE}

