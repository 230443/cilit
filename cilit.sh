#!/bin/bash -x
# -x = tracing

##### Constants


##### Functions

usage()
{
	echo 	" cilit - moves given files to trashbin
		
		usage: cilit [[-v] | [-h] | file]

		-h	display this help and exits
		-v	outputs version information
		file	file or directory to be deleted

		written by Daniel Baraniak and Tomasz Kolas"
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
	case $1 in
		/*) 	local absolute=$1;;
		*)	local absolute=${2%/*}/$1;;
	esac


	if [ -f "$absolute" ]; then
		if [ "$absolute" == "*trashbin.cfg" ]; then
			"$absolute" >> $temp
		else	
			mkdir -p ~/trashbin${absolute%/*}	#create line of folders
			mv "$absolute" ~/trashbin${absolute%/*}
		fi
	fi
}

##### Main

if [ -n "$1" ] 
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

if [ -f "$absolute" ]; then	
	mkdir -p ~/trashbin${absolute%/*}	#create line of folders
	mv $absolute ~/trashbin${absolute%/*}	
elif [ -d "$absolute" ]
then
	temp=$(mktemp)
	for f in $(find $absolute -type f -name trashbin.cfg)
	do
		while read line 
			do
				mvfile ${line} $f
			done < $f
	done
fi

while read line 
	do
		mkdir -p ~/trashbin${line%/*}	#create line of folders
		mv $line ~/trashbin${line%/*}	
	done < $temp

rm $temp
