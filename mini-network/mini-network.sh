#!/bin/bash

echo "Hello from admin1"

ping -c3 192.168.56.11
ping -c3 192.168.56.12

# cat /etc/hosts

# sudo echo "192.168.56.11 server1" >> /etc/hosts       ## permission denied

# echo "192.168.56.11 server1" | sudo tee -a /etc/hosts
# echo "192.168.56.12 server2" | sudo tee -a /etc/hosts

# cat /etc/hosts

ping -c3 server1 
ping -c3 server2

### connect with server1 with ssh without password

## 1. generate ssh key
# ssh-keygen

## adding this public key on server1    # add password for server1 - vagrant
# ssh-copy-id server1
# ssh-copy-id server2 

# ssh server1
# ssh server2


ssh server1 hostname                        ## runs command on server1
ssh server2 'echo "Hello from server2"'     ## runs command on server2


# for N in 1 2
# do  
#     ssh server${N} hostname
# done


echo 'server1' > servers
echo 'server2' >> servers

for SERVER in $(cat servers)
do  
    ssh ${SERVER} hostname
done

# rm servers


ssh server1 hostname; hostname          ## server1 admin1
ssh server1 'hostname; hostname'        ## server1 server1


COMMAND1="hostname"
COMMAND2="uptime"

ssh server1 "${COMMAND1}; ${COMMAND2}"


ssh server1 'ps -ef | head -4'


ssh server3 uptime
echo ${?}

ssh server1 uptime
echo ${?}

ssh server1 'true'  
echo ${?}               ## 0

ssh server1 'false'  
echo ${?}               ## 1        ## exit status of last executed command
 
ssh server1 'false | true'  
echo ${?}               ## 0
 
ssh server1 'true | false'  
echo ${?}               ## 1    ## exit status of last executed command


ssh server1 'set -o pipefail; false | true'
echo ${?}               ## 1    ## exit status of last failed command in pipeline



SERVER_FILE="/vagrant/servers"

if [[ ! -e "${SERVER_FILE}" ]]
then 
    echo "Cannot open ${SERVER_FILE}" >&2
    exit 1
fi

for SERVER in $(cat ${SERVER_FILE})
do  
    echo "pinging ${SERVER}"
    ping -c1 ${SERVER} &> /dev/null 

    if [[ "${?}" -ne "0" ]]
    then
        echo "${SERVER} down"
    else
        echo "${SERVER} up"
    fi
done


ssh server1 sudo id     ## root previledge on server1
sudo ssh server1 id     ## root previledge on admin1

rm servers
