#!/bin/bash -x
# -x = tracing

##### Constants


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
	if  [ -e "$1" ] 
	then
		filename=$1

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
        * )                     does_exist $1
    esac
else
	echo "No argument"
	usage
	exit 1
fi


# if trashbin exist
if  [ ! -d ~/trashbin ]; then
	# creating trashbin
	mkdir ~/trashbin
	echo "creating trashbin"
fi
mvfile ()
{
case $1 in
	/*) 	local absolute=$1;;
	*)	local absolute=$PWD/$1;;
esac

if [ -f $1 ];
then
	mkdir -p  ~/trashbin${absolute%/*}	#create line of folders
	mv $absolute ~/trashbin${absolute%/*}
fi
}

if [ -d $filename ]
then
	find $filename -type f -name trashbin.cfg
