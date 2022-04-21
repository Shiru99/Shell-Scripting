#!/bin/bash

# !xyz -> runs last command with xyz as initials

### Generate list of random password ###

PASSWORD=${RANDOM}${RANDOM}${RANDOM}
echo "Random generated password - ${PASSWORD}"

# date      ## Thu Apr 21 01:37:03 EDT 2022
# date +%Y  ## 2022
# date +%T  ## HH:MM:SS
# date +%D  ## MM/DD/YYYY
# date +%s  ## Seconds since epoch (1970-01-01 00:00:00 UTC)
# date +%N  ## Nanoseconds since epoch (1970-01-01 00:00:00 UTC)

PASSWORD=$(date +%s)
echo "Date generated password - ${PASSWORD}"

## Nanoseconds - as random number
PASSWORD=$(date +%s.%N)
echo "Date generated password - ${PASSWORD}"

# echo "Hello"
# echo "Hello" | sha256sum
# echo "Hello" | sha256sum | head -c10

## Nano Seconds + encrypted by sha256sum for strong radomness
PASSWORD=$(date +%N${RANDOM} | sha256sum | head -c10)
echo "Nano seconds + random + sha256sum generated 10char password - ${PASSWORD}"

SPECIAL_CHARACTERS='!@#$%^&*()_+'

# shuf /etc/passwd                  ## Shuffles the input
# fold -w10 /etc/passwd             ## Folds input into words of 10 character

SPECIAL_CHAR=$(echo ${SPECIAL_CHARACTERS} | fold -w1 | shuf | head -c1) 
PASSWORD=$(date +%N${RANDOM} | sha256sum | head -c9)${SPECIAL_CHAR}
echo "Nano seconds + random + sha256sum +  + special char generated 10char password - ${PASSWORD}"

