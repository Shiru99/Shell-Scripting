#!/bin/bash

# type -a sort
# man sort

sort /etc/passwd
sort -r /etc/passwd             ## revearse the order

cut -d ':' -f 3 /etc/passwd | sort              ## String sorting
cut -d ':' -f 3 /etc/passwd | sort -n           ## Numbers sorting

# type -a du
# man du
cd /
sudo du
sudo du | sort -n 

netstat -nutl | grep -E -v '^Active|^Proto' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -u -n          ## u - unique


netstat -nutl | grep -E -v '^Active|^Proto' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq      ## uniq - works only with sorted nums

netstat -nutl | grep -E -v '^Active|^Proto' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq -c   ## -c - count


sudo cat /var/log/messages
sudo cat /var/log/messages | awk '{print $5}' | sort | uniq -c
sudo cat /var/log/messages | awk '{print $5}' | sort | uniq -c | sort -n | tail -n 3


# type -a wc
# man wc
wc /etc/passwd
wc -l /etc/passwd       ## lines
wc -w /etc/passwd       ## words
wc -c /etc/passwd       ## chars

grep bash /etc/passwd | wc -l

cat /etc/passwd | sort -n -t ':' -k 3

