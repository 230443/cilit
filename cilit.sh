#!/bin/bash -x
# -x = tracing

##### Constants

filename=

##### Functions

usage()
{
	echo 	"usage: cilit [[-v] | [-h] | file]
		-h	help
		-v	version
		file	file or directory to be deleted"
	#further describtion
}

version()
{
	echo "v1.0"

}

does_exist()
{
	if ! [ -e $1 ] 
	then 
		echo "File does not exist"
		exit 1	
	fi
}


##### Main


case $1 in
        -h | --help )           usage
                                exit
                                ;;
        -v | --help )           version
                                exit
                                ;;
        * )                     does_exist
                                break
    esac


# if trashbin exist
if ! [ -d ~/trashbin ]; then
	# creating trashbin
	mkdir ~/trashbin
fi
       



