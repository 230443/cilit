#!/bin/bash -x
# -x = tracing

##### Constants

filename=$1

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
	if  [ -e "$filename" ] 
	then
		echo "file accepted"
	else	
		echo "File does not exist"
		exit 1	
	fi
}


##### Main

if [ $1 != "" ] 
then	
case $1 in
        -h | --help )		usage
                                exit
                                ;;
        -v | --version )	version
                                exit
                                ;;
        * )                     does_exist
    esac
fi


# if trashbin exist
if  [ ! -d ~/trashbin ]; then
	# creating trashbin
	mkdir ~/trashbin
	echo "creating trashbin"
else
	echo "trashbin exists"
fi
