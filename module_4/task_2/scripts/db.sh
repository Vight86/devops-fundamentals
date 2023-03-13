#!/bin/bash

if [ $1 = 'add' ];
  then
    if ! [ -f ../data/users.db ];
      then
        install -m 777 ../data/users.db
        echo 'Users.db created'
      else
        read -p 'Username: ' user
          if [[ $user =~ [^a-zA-Z] ]];
            then 
              echo 'Username should be only latin characters'
            else 
              read -p 'Role: ' role
                if [[ $role =~ [^a-zA-Z] ]];
                  then 
                    echo 'Role should be only latin characters'
                  else 
                    echo "$user, $role" >> ../data/users.db
                    echo User $user created
                fi
          fi
    fi
fi

if [ $1 = 'backup' ];
  then
    if ! [ -f ../data/users.db ];
      then echo 'No file users.db'
      else
        cat ../data/users.db >> "../data/%$(date)%-users.db.backup"
        echo 'Backup created'
    fi
fi

if [ $1 = 'restore' ];
  then
    if [[ $( find ../data/*-users.db.backup ) ]];
      then
        #backup=$( find ../data/*-users.db.backup )
        cat ../data/*-users.db.backup > ../data/users.db
        echo Backup restored
      else
        echo No backup
    fi
fi

if [ $1 = 'list' ];
  then
    if [[ $( find ../data/users.db ) ]];
      then
        if [ $2 == "--inverse" ];
          then
            number=$( cat ../data/users.db | wc -l )
            tac ../data/users.db | while read p;
              do
                echo "$number. $p"
                (( number-- ))
            done
          else
            number=1
            cat ../data/users.db | while read p;
              do
                echo "$number. $p"
                (( number++ ))
            done
        fi
      else
        echo Nu users.db
    fi
fi