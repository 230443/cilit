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
	fi
}


mvfile ()
{	#mvfile line trashbin.cfg_path
	case $1 in
		/*) 	local absolute=$1;;
		*)	local absolute=$PWD/$1;;
	esac

	if [ -f $absolute ]; then
		if [[ $absolute =~ .*trashbin.cfg ]]; then
			echo $absolute >> $temp
		else	
			mkdir -p ~/trashbin${absolute%/*}	#create line of folders
			mv $absolute ~/trashbin${absolute%/*}
		fi
	fi
}

##### Main

if [ -n "$1" ] 
then	
while [ -n "$1" ]; do
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
    done
else
	echo "No argument"
	usage
	exit 1
fi

# if trashbin exist
if  [ ! -d ~/trashbin ]; then
	# creating trashbin
	mkdir ~/trashbin
fi

# mvfile $filename $PWD
temp=$(mktemp)
if [ ! -L $filename ]; then
for absolute in $(readlink -e $filename) #expand ../ ./
do
	if [ -f "$absolute" ]; then	
		mkdir -p ~/trashbin${absolute%/*}	#create line of folders
		mv $absolute ~/trashbin${absolute%/*}	
	elif [ -d "$absolute" ]
	then
		for f in $(find $absolute -type f -name trashbin.cfg)
		do
			cd ${f%/*} #change directory lvl above trashbin.cfg
			while read line 
			do
				for file in $(echo $line) #expand regular exp
					do 
						mvfile $file
					done
			done < $f
		done
	fi
done
else
	
	case $1 in
		/*) 	absolute=$1;;
		*)	absolute=$PWD/$1;;
	esac
			mkdir -p ~/trashbin${absolute%/*}	#create line of folders
			mv $absolute ~/trashbin${absolute%/*}
fi

	while read line 
		do
			mkdir -p ~/trashbin${line%/*}	#create line of folders
			mv $line ~/trashbin${line%/*}	
		done < $temp
rm $temp
