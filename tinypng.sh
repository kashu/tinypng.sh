#!/bin/bash
#Author: https://kashu.org
#Date: 2016-01-30
#Filename: tinypng.sh
#Description: Advanced lossy compression for PNG/JPG images.

# Check if the curl command is executable
if [ ! -x "`which curl | head -1`" ]; then
	echo "Could not execute /usr/bin/curl"
	exit 1
fi

# Create a directory to backup the original images
backup="/tmp/img_original_`date +%Y%m%d_%H%M%S`"
mkdir $backup &> /dev/null
if [ ! -d "$backup" ]; then
	exit
fi

compress(){
	find "$img_path" -maxdepth $max \( -iname "*.png" -o -iname "*.jpg" \) 2> /dev/null | while read file; do
		#pic_url=`curl -sif --user api:API_KEY --data-binary @${file} https://api.tinypng.com/shrink|awk -F'"'  '/input/{print $(NF-1)}'`
		pic_url=$(curl -sif --user api:API_KEY --data-binary @"${file}" https://api.tinify.com/shrink|awk -F'"'  '/input/{print $(NF-1)}')
		# if failed to get the url link, then skip that image
		if [ -z "$pic_url" ]; then
			continue
		fi
		suffix=${file##*.}
		suffix_lower=${pic_url##*.}
		mv --backup=t "${file}" $backup
		wget --no-check-certificate "$pic_url" -O "${file%.*}.${suffix_lower}"
	done
}

dir_err(){
	echo -e "$1"" is not a valid directory.\n"
}

help_info(){
	cat <<- END
	Advanced lossy compression for PNG or JPG images.
	* Internet connectivity is required before use this shell.

	Options:
	-r|-R        Recursively compress images
	-h|--help    Print help info

	Usage:
	$0 [-r|-R] [/path/to/img]
	END
	exit
}

case "$1" in
	-h|--help)
		help_info ;;
	-r|-R)
		shift 1
		if [ -d "$1" ]; then
			img_path="$1"
			max=40
			compress
		elif [ -z "$1" ]; then
			img_path="$PWD"
			max=40
			compress
		else
			dir_err; help_info
		fi ;;
	*)
		if [ -d "$1" ]; then
			img_path="$1"
			max=1
			compress
		elif [ -z "$1" ]; then
			img_path="$PWD"
			max=1
			compress
		else
			dir_err; help_info
		fi ;;
esac
