#!/bin/bash

# this function will be run from a different script case there was any prompt used
#what we get will be a file named current_users, same one will be read by monitor_1  so this file can get users variable and attach it"

w > mirror
count=0
sed -i '1d' mirror
sed -i '1d' mirror
[ -f "current_users" ] && rm "current_users"
touch "current_users"
while IFW= read -r line
do
    line=$(echo "$line" | cut -d " " -f1)
    echo "$line" >> "current_users"
done < mirror
