#!/bin/bash

##In order to verify which user and when used specific prompts

##Would be optimnal to run it trhough flags each 15 seconds, case we want to stop it we only delete our flag "blue" 

#I advice to veriufy that no one has any permissions on bash _history. so this cripts get clean output 
[ -f "blue" ] || touch "blue"
while [ -f "blue" ]
do
        
        array=()
        array+=("apt-get") ##prompts or values we want to monitor or aviid // aadd as many prompts as you need to monitor to the array
        array+=("prompt2")
        array+=("prompt3")
        
        verify=()
        count=0
        triggered="no"
        countC=0
        array2=()
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
                        countC=$((countC+1))
                        if [[ "$countC" == 0 ]];
                         then
                            :
                        else
                            ./get_user.sh ##will create a file named current_users, from same we extract the current users if thats the case
                            users=()    ##array
                            while IFW= read -r lineB
                            do
                                users+=("$lineB")
                            done < current_users
                        verify+=("WARNING: $line was used on $(date) with following users on ssh: ${users[@]}")
            
                        triggered="yes"
                        array2+=("$line")
                    fi
                done
            fi
        done 
        
        done < "/root/.bash_history"
        
        trigger_log="/root/system_logs/logs/monitor_1"  ##so you can log the info // CHANGE
        [[ "${verify[@]}" == "" ]] || echo "${verify[@]}    ALERT SENT ON $(date)" >> "$triggers_log"
        [[ "${verify[@]}" == "" ]] || echo "${verify[@]}"
        [[ "${verify[@]}" == "" ]] && echo "empty"
        
        ##I would advice to triggger a mial sending indtead of the echo, mailutils prompt could d the thing
        #[[ "${verify[@]}" == "yes" ]] || echo "Should notify trough mail service"
        if [[ "${verify[@]}" == "" ]];
         then
                :
        else
            echo "the following prompts were used within the server:
                "${verify[@]}"
            | mail -a FROM:"server@serverdomain" "yourmail@serverdomain" --subject="Security Notification"
        fi
        
        echo "triggered:$triggered"
        echo "qty=$countC"
        echo "${array[@]}"
        echo "${#array[@]}"
        
        sleep 15 #we could set this for different frames of times, either way could be set uo trhough crone job although the minimal there goes for 1 minute
done








