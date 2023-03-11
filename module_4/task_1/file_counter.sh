#!/bin/bash

if [[ $# -eq 0 ]]
    then echo "Provide direcory path"
    
    else
        files=$(ls -Rp "$1" | grep -v /)
        filesarray=($files)
        echo ${#filesarray[@]}
fi