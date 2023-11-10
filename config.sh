#!/bin/bash

File="ssh_config"

## create a file we will write to
temp_config="temp_config"
if [[ -f $temp_config ]]
then
    rm -rf $temp_config
fi

touch $temp_config

while read -r line 
do

    ## Look for hash #
    # check if the line starts with #
    check_password_line=$(echo $line | grep "PasswordAuthentication")

    if [[ $check_password_line ]]
    then 
        ### it matched here
        if [[ ${check_password_line:0.1} == "#" ]]
        then
            # this password setting is commented out
            echo "PasswordAuthentication yes" >> $temp_config
        else
            # this password setting is not commented out
            echo "PasswordAuthentication yes" >> $temp_config
        fi
    else
        # place back
        echo $line >> $temp_config
    fi



done < $File

rm -r 'ssh_config'
mv temp_config ssh_config