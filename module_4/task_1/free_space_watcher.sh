#!/bin/bash
FREE_SPACE_THRESHOLD=20

if ! [[ $# -eq 0 ]];
    then
        if [[ $1 =~ ^-[0-9]+$ ]];
        then
            input_threshold=$(echo $1 | sed s/-//g)
            FREE_SPACE_THRESHOLD=$input_threshold
    fi
fi

df -Ph | grep "/dev/sda*" | while read data

do 
    disks=$(echo $data | awk '{print $1,$5}')

    disk=$(echo $data | awk '{print $1}')

    used=$(echo $disks | awk '{print $2}' | sed s/%//g)

    free=$((100-$used))

    if [ $FREE_SPACE_THRESHOLD -gt $free ];
        then
            echo "$disk: free space is less threshold"
        else
            echo "$disk: have free space"
    fi
done