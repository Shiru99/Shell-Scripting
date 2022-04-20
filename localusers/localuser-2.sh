#!/bin/bash

### Display the UID - user ID ###
echo "Your UID - ${UID}"
# echo "Your EUID - ${EUID}"

## UID is the original user, EUID is the user you changed to. usually UID & EUID are same but not always the case. sudo - 0, normal user - 1000

### Display the username ###
# id
# type id
# man id
# id -u -n # "-u -n" = "-n -u" = "-un" = "-nu"
USERNAME=$(id -un)      ## $(id -un) = `id -un`  
echo "Your username - ${USERNAME}"

# whoami
# type whoami       # whoami is /usr/bin/whoami
# man whoami

### Check if username is root ###

# if [[ exit ]]; then echo "execution with exit 0"; fi

# if [[ exit ]]; then echo "execution with exit 0"; echo "hello"; fi

# if [[ ! exit ]]  ## 'new line' or ';' to seperate the commands
# then 
#     echo "execution with exit 0"
#     echo "hello"
# else
#     echo "execution with exit error"
# fi

: '
    if statement - checks for the exit status of the command executed.

    [[ test ]]   - space before and after [[ ]] is important
            - Returns a status (exit status) of 0 or 1 depending on the evaluation of the expression i.e. test

    help test 

        File operators:
        String operators:
        Other operators:

'

if [[ "${UID}" -eq 0 ]]             
then
    echo "You are root"
elif [[ "$(id -un)" -eq "vagrant" ]]    
then 
    echo "You are vagrant user"
else
    echo "You are new user"
fi

