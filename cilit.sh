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


mvfile ()
{	#mvfile line trashbin.cfg_path
#	local var2=$2
case $1 in
	/*) 	local absolute=$1;;
	*)	local absolute=${2%/*}/$1;;
esac

if [ -f $absolute ];
then
	mkdir -p  ~/trashbin${absolute%/*}	#create line of folders
	mv $absolute ~/trashbin${absolute%/*}
#elif [ -d $absolute ]
#then
#	for f in $(find $absolute -maxdepth 1 -type f -name trashbin.cfg)
#	do
#		for line in ($f) 
#			do
#				mvfile ${line} $f
#			done
#	done
fi
}

##### Main

if [ -z "$1" ] 
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
    shift
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

# mvfile $filename $PWD

case $filename in
	/*) 	absolute=$filename;;
	*)	absolute=$PWD/$filename;;
esac

if [ -f $absolute ] then;
	mvfile $absolute
if [ -d $absolute ]
then
	for f in $(find $absolute -type f -name trashbin.cfg)
	do
		for line in ($f) 
			do
				mvfile ${line} $f
			done
	done

