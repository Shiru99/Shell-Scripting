#!/bin/bash 

### Cut ###
# type -a cut
# man cut

# cut -c1 /etc/passwd           ## 1st char of each line 
# cut -c999 /etc/passwd         ## blank lines
cut -c 1,3,5,7 /etc/passwd      ## char 1,3,5,7
cut -c 1,5,7,3 /etc/passwd      ## 1,5,7,3 -> char 1,3,5,7 == 

cut -c 2-10 /etc/passwd         ## from 2nd char to 10th char
cut -c 10- /etc/passwd          ## from 10th char
cut -c -10 /etc/passwd          ## till 10th char

echo -e '1\t2\t3\n4\t5\t6' | cut -f 2       ## field - by default tab
echo -e '1,2,3\n4,5,6' | cut -d ',' -f 3    ## delimiter - ','  [ONLY 1 CHAR]

cut -d ':' -f 1,3 /etc/passwd       ## Username & UID
cut -d ':' -f 1,3  --output-delimiter=',' /etc/passwd       ## Username & UID

echo "John,Doe" > temp
echo "jenny,Doe" >> temp
echo "James,Doe" >> temp
echo "Joe,Doea" >> temp

### GREP ###
# type -a grep
# man grep

grep "^Jo" temp
grep "oe$" temp
grep -v "^Jo" temp      ## -v acts as compliment of pattern

grep -v "^Jo" temp | cut -d ',' -f 1

### AWK ###

# type -a awk
# man awk

echo "Data:John,Data:Doe" > temp
echo "Data:jenny,Data:Doe" >> temp
echo "Data:James,Data:Doe" >> temp
echo "Data:Joe,Data:Doea" >> temp

awk -F 'Data:' '{print $2 $3}' temp



awk -F ':' '{print $1, $3}' /etc/passwd                         ## UN UID
awk -F ':' -v OFS='-' '{print $1, $3}' /etc/passwd              ## UN-UID
awk -F ':' '{print $1 "-" $3}' /etc/passwd                      ## UN-UID
awk -F ':' '{print "UN: "$1 ",\t" "UID: " $3}' /etc/passwd      ## UN: root,	UID: 0
awk -F ':' '{print $3, $1}' /etc/passwd                         ## UID UN
awk -F ':' '{print $NF}' /etc/passwd                            ## NF - last field
awk -F ':' '{print $(NF-1)}' /etc/passwd                        ## 2nd last

echo "John     Doe" > line
echo "   James Doe" >> line
echo "Joe Doea    " >> line
echo " Jenny  Doe " >> line

awk '{print $1, $2}' line       ## Default delimiter - white spaces

rm temp line


### Example get used ports

# type -a netstat
# man netstat

netstat -nutl | grep -E -v '^Active|^Proto'

netstat -nutl | grep -E -v '^Active|^Proto' | awk '{print $4, $1}' 
netstat -nutl | grep -E -v '^Active|^Proto' | awk '{print $4}' | awk -F ':' '{print $NF}'

## IPv4
netstat -4nutl | grep -E -v '^Active|^Proto' | awk '{print $4}' | cut -d ':' -f 2

