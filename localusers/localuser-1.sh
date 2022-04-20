#!/bin/bash 

# '#' - sharp   '!' - bang   '#!' - shebang
# /bin/bash - path of file executor

### File Permissions ###
# chmod : -rwx : 421

# . - current directory
# .. - parent directory

### Display Hello ###
echo "Hello"

# type echo  # echo is a shell built-in command
# type uptime
# type -a echo

# help echo     # help only for built-in command
# help echo | less
# man echo      


### Assign value to variable ###
VAR_1="Hello, World"    # Convenstion - UPPERCASE for variables
# var_0 = 1     ## No spaces before & after =

### Display value using variable ###
# echo VAR_1          # VAR_1
# echo '$VAR_1'       # $VAR_1  ## single quotes do not cause variable expansion
echo "$VAR_1"         # Hello, World
# echo $VAR_1         # Hello, World

### Append text to variable ###

# _var1=4
# _var2=9
# echo "$_var1 + $_var2" # 4 + 9

# echo "message from script - $VAR_1"
## echo "message from script - $(VAR_1)"    # $(command) or `command` 
# echo "message from script - $(echo hi)"   # $() -> executes command inside () & substitute
# echo "message from script - ${VAR_1}"
# echo "message from script - $VAR_1s"
echo "message from script - ${VAR_1}s"

### Reassignment ###
VAR_1="Hello, There"
echo "$VAR_1"

# VAR_2="date"

# echo "message is $VAR_2"        # date
# echo "message is ${VAR_2}"      # date
# echo "message is $(VAR_2)"      # VAR_2: command not found
# echo "message is $(date)"       # Wed Apr 20 12:48:11 EDT 2022  
# echo "message is $($VAR_2)"     # Wed Apr 20 12:48:11 EDT 2022  
# echo "message is `VAR_2`"       # VAR_2: command not found
# echo "message is `$VAR_2`"      # Wed Apr 20 12:48:11 EDT 2022
# echo "message is `date`"        # Wed Apr 20 12:48:11 EDT 2022
# echo "message is '$VAR_2'"      # 'date'
# echo "message is \"$VAR_2\""    # "date"


### ARITHMATIC OPERATIONS ###

# M-1 using - $(( ))

NUM1=11
NUM2=5

echo "Sum - $(( ${NUM1} + ${NUM2} ))"   ## $(( ${NUM1} + ${NUM2} )) === $(( NUM1 + NUM2 ))
echo "Sub - $(( NUM1-NUM2 ))"
echo "MUL - $(( NUM1*NUM2 ))"
echo "DIV - $(( NUM1/NUM2 ))"
echo "MOD - $(( NUM1%NUM2 ))"

NUM1=$(( NUM1+1 ))
echo "Num1 - ${NUM1}"

(( NUM1++ ))
echo "Num1 - ${NUM1}"

(( --NUM1 ))
echo "Num1 - ${NUM1}"

(( NUM1+=5 ))
echo "Num1 - ${NUM1}"

(( NUM1*=5 ))
echo "Num1 - ${NUM1}"

echo "Num1 - $((NUM1--))"
echo "Num1 - ${NUM1}"


# M-2 - using let
NUM1=11
let NUM1++
echo "Num1 - ${NUM1}"

let NUM1='9+9'
echo "Num1 - ${NUM1}"

# M-3 using expr

NUM1=11
NUM1=$(expr 7 / 4)
echo "Num1 - ${NUM1}"

NUM1=$(expr ${NUM1} + 4)
echo "Num1 - ${NUM1}"
