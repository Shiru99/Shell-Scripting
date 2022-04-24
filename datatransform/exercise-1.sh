#!/bin/bash

## log file - http://www.cs.fsu.edu/~langley/CIS4385-2015-1/2015-01-logs-test/auth.log
## expected OUTPUT : Count,IP,Location


# cat auth.log
# grep Failed auth.log
# grep Failed auth.log | awk -F 'from ' '{print $2}'
# grep Failed auth.log | awk -F 'from ' '{print $2}' | cut -d ' ' -f 1
# grep Failed auth.log | awk -F 'from ' '{print $2}' | cut -d ' ' -f 1 | sort -n
# grep Failed auth.log | awk -F 'from ' '{print $2}' | cut -d ' ' -f 1 | sort -n | uniq -c
# grep Failed auth.log | awk -F 'from ' '{print $2}' | cut -d ' ' -f 1 | sort -n | uniq -c | sort -rn
# grep Failed auth.log | awk -F 'from ' '{print $2}' | cut -d ' ' -f 1 | sort -n | uniq -c | sort -rn | awk '{print $1 "," $2}'

# type -a geoiplookup
# man geoiplookup 


LIMIT='10'
LOG_FILE="${1}"

if [[ ! -e "${LOG_FILE}" ]]
then 
    echo "Cannot open log file: ${LOG_FILE}" >&2
    exit 1
fi


grep Failed "${LOG_FILE}" | awk -F 'from ' '{print $2}' | cut -d ' ' -f 1 | sort -n | uniq -c | sort -rn | 
while read COUNT IP
do
    if [[ "${COUNT}" -gt "${LIMIT}" ]]
    then
        LOCATION=$(geoiplookup "${IP}" | awk -F ', ' '{print $2}')
        echo "${COUNT},${IP},${LOCATION}"
    fi
done

exit 0