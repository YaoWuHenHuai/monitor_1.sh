#!/bin/bash

##In order to verify which user and when used specific prompts

##Could set this trhoguh cronjob, so it runs, 

#I advice to veriufu that no one has any permissions on bash _history. so this cripts get clean output 

array=()
array+=("apt-get) ##prompts or values we want to monitor or aviid // aadd as many prompts as you need to monitor to the array
array+=("prompt2")
array+=("prompt3")

verify=()
count=0
triggered="no"
countC=0

##mirroring file.
[ -f "mirroring" ] || touch "mirroring"

while IFW= read -r line
do
    [[ "$line" =~ "$array" ]] && count=$((count+1))
    countB=$((countB+1))
    line="row#$countB $line"

    if grep -q "$line" "/root/system_logs/mirroring";
     then
        :
    else
        echo "$line" >> "/root/system_logs/mirroring"
        echo "$line was added to mirroring file" 
        #this is the value we verify wheter was used or not

        for prompt in "${array[@]}"
        do
            if [[ "$line" =~ "$prompt" ]];
             then
                verify+=("WARNING: $line was used on $(date) by user $(whoami)")
                countC=$((countC+1))
                triggered="yes"
            fi
        done
    fi
done 

done < "/root/.bash_history"

trigger_log="/root/system_logs/logs/monitor_1"  ##so you can log the info // CHANGE
[[ "${verify[@]} == "" ]] || echo "${verify[@]}    ALERT SENT ON $(date)" >> "$triggers_log"
[[ "${verify[@]} == "" ]] || echo "${verify[@]}"
[[ "${verify[@]} == "" ]] && echo "empty"

##I would advice to triggger a mial sending indtead of the echo, mailutils prompt could d the thing
[[ "${verify[@]} == "yes" ]] || echo "Should notify trough mail service"

echo "triggered:$triggered"
echo "qty=$countC"
echo "${array[@]}"
echo "${#array[@]}"









