#! /bin/bash

echo "Package info"
echo "Author: Artem"
echo "Using this program you can find info about needed package or install it"

user_response="y"

while [[ $user_response = "y" ]]
do
	echo "Type package name"
	read packname 
	yum info $packname 2> /dev/null 1> /dev/null
	if [[ $? != 0 ]]
		then
		echo "Package is not installed!" >&2
		echo "Do you want to install it? (y/n?)"
		read user_response
		if [[ $user_response = "n" ]]
			then
			echo "Do you want to continue? (y/n)"
			read user_response
			if [[ $user_response = "n" ]]
				then
				exit 0
			else
				continue
			fi
		else
			yum install $packname
            if [[ $? != 0 ]]
            then
                echo "Something went wrong!" >&2
                echo "Do you want to continue? (y/n)"
                read user_response
                if [[ $user_response = "n" ]]
                    then
                    exit 1
                else
                    continue
                fi
            else
                echo "Packege installed!"
                echo "Do you want to continue? (y/n)"
                read user_response
                if [[ $user_response = "n" ]]
                    then
                    exit 0
                else
                    continue
                fi
            fi
		fi
	fi
    
	yum info $packname
    echo "Do you want to continue? (y/n)"
    read user_response
    if [[ $user_response = "n" ]]
        then
        exit 0
    else
        continue
    fi

done
