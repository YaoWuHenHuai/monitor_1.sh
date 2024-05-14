#/bin/bash

# this function will be run from a different script case there was any prompt used
#what we get will be a file named current_users, same one will be read by monitor_1  so this file can get users variable and attach it"

w > current_users
count=0
sed -i '1d' current_users
sed -i '1d' current_users
while IFW= read -r line
do
    line=$(echo "$line" | cut -d " " -f1)  
fi
done < current_users
