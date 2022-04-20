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
