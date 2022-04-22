#!/bin/bash

echo "hello from - USERDEL"

# type -a userdel
# man userdel

### locate ###
# locate userdel

# touch myuserdel
# locate myuserdel
# sudo updatedb         ## need to update the locate database 
# locate myuserdel

sudo locate userdel | grep bin

### find ###
# find /usr/bin -name userdel
find /usr/sbin -name userdel

find / -name userdel 2> /dev/null
# sudo find / -name userdel 2> /dev/null


: ' Terminal shortcuts 

        !!  - previouse command
        !xyz  - previouse command with xyz as initials
        !$ - last argument of last command 

'

### userdel ###

# sudo ./exercise-3.sh John John Doe
sudo ./exercise-3.sh Jenny Jenny Doe
# sudo ./exercise-3.sh James James Doe
# echo 

# tail -3 /etc/passwd
# echo
# ls -l /home
# echo

# id -u root      # 0
# id -u sshd      # 74
# id -u           # 1000

# sudo userdel John
# sudo ls -l /home/John

# sudo userdel -r James
# sudo ls -l /home/James

# Archived users
# sudo userdel John
# sudo tar -cf archive-John.tar /home/John/



### tar & gzip ###
# mkdir hello/
# touch hello/hi hello/bye
# tar -cf archive-hello.tar hello/        # create tar archive;   -cvf : v - verbose
# tar -tvf archive-hello.tar
# tar -xf archive-hello.tar               # extract from tar;     -xvf : v - verbose

# gzip archive-hello.tar          ##  gzip - compress file
# gunzip archive-hello.tar.gz     ##  gunzip - decompress file

# tar -zcvf archive-hello.tar.gz hello/         ## .tar.gz == .tgz
# tar -ztvf archive-hello.tar.gz
# tar -zxvf archive-hello.tar.gz

# rm -rf hello/
# rm *tar
# rm *gz

### Disable user account ###

tail -3 /etc/passwd
echo

## chage
sudo chage -E 0 Jenny           # account expired
## su - Jenny
sudo chage -E -1 Jenny          # account re-enabled

## passwd (for effective incase of SSH)
sudo passwd -l Jenny            # account locked
sudo passwd -u Jenny            # account unlocked

## Shells
# cat /etc/shells

## usermod - change the shell of an existing user (Valid for SSH)
sudo usermod -s /sbin/nologin Jenny     # nologin - disables the ability for the user to log in

sudo userdel -r Jenny
