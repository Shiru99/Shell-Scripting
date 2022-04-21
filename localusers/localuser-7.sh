#!/bin/bash

### while loop

# while [[ true ]]      ## infinite loop
# do
#     echo "Inside while loop"
#     sleep 1
# done

### While loop through arguments

# type -a shift
# help shift

while [[ "${#}" -gt 0 ]]
do 
    echo "Number of arguments - ${#}"
    echo "Arguments - ${*}"
    echo
    shift 1
done
