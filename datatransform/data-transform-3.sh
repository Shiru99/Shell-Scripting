#!/bin/bash

### Sed - Stream editor ###
# type -a sed
# man sed

echo "hello there. " > temp
echo "greetings of the day. " >> temp
echo "Hope you are doing great. " >> temp
echo "Go there & enjoy stuff available there " >> temp


## Substitute Command - s

# cat temp | sed 's/there/world/'          ## only 1st occurrence
# echo

# cat temp | sed 's/there/world/g'          ## all occurrence
# echo

# cat temp | sed 's/there/world/2'          ## only 2nd occurrence
# echo

# cat temp | sed 's/THERE/World/'
# echo

cat temp | sed 's/THERE/World/i'        ## i - case insensitive 
echo

echo "line 0" >> temp
echo "This is line 1" >> temp
echo "This is line 2" >> temp
echo "hello,This is line 3" >> temp

cat temp | sed '6s/LiNe/command/i'              ## works only with line no. 6 
cat temp | sed '6,9 s/LiNe/command/i'           ## works only with lines 6 to 9
cat temp | sed '/This/ s/LiNe/command/i'        ## works only with lines having 'this'


# sed 's/THERE/World/i' temp
sed -i.backup 's/THERE/World/ig' temp    ## updates changes in temp & create backup with .backup

echo "/home/vagrant" | sed 's/\/home/\/sys\/users/'
echo "/home/vagrant" | sed 's#/home#/sys/users#'    ## any delimiter other than '/' wil work
echo "/home/vagrant" | sed 's:/home:/sys/users:'

rm temp temp.backup


## Delete Command - d

echo "hello there" > temp
echo "This is line 1" >> temp
echo "This is line 2" >> temp
echo "This is line 3" >> temp

cat temp | sed '/This/d'            ## delete all lines containing 'This'




echo > conf
echo "# print 'hello there' on screen" >> conf
echo "echo 'hello There'" >> conf
echo >> conf
echo "# list directory contents" >> conf
echo "ls -a     \t\t\t\t# -a : do not ignore entries starting with ." >> conf
echo >> conf

# cat conf | sed '/^#/d'          ## removes lines starting with '#'
# cat conf | sed '/^$/d'          ## removes empty line 

# m-1
cat conf | sed '/^#/d; /^$/d; s/\\t/    /g'  

# m-2
cat conf | sed -e '/^#/d' -e '/^$/d' -e 's/\\t/    /g'  

# m-3
echo '/^#/d' > script.sed
echo '/^$/d' >> script.sed
echo 's/\\t/    /g' >> script.sed

cat conf | sed -f script.sed 


rm conf temp script.sed


