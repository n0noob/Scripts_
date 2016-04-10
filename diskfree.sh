#!/usr/bin/env ksh

set -o errexit
set -o nounset
#Use xtrace only for debugging purpose
#set -o xtrace
set -o pipefail

BUILD_DIR=$(ls ~ -ltrS|grep "^d"|awk '{print $9}'|grep "^IC_"|head -1)
RE='^[0-9]+$'

menu()
{
	while true
	do
		print "\n************************************************************************"
		print "Disk free tool"
		print "************************************************************************"
		print "\nCurrently you have $(df $HOME -h|awk '{print $4}'|tail -1) free space left"
		print "\n1. Display top 10 largest files"
		print "\n2. Find if multiple versions of libs are there in distribute"
		print "\n3. Find if multiple versions of libs are there in build"
		print "\n\nINPUT: "
		read ip
		case $ip in
		1)
			disp_topten
			;;
		2)
			disp_distribute
			;;
		3)
			disp_build
			;;
		*)
			print "Invalid Input !!\n Exiting!"
			break;
		esac
	done
}

disp_topten()
{
	print "SIZE	FILE_PATH"
	find ~ -type f -print|xargs du -sk 2>/dev/null|sort -rn|head -10
}

disp_distribute()
{
	ls -1 "$HOME/$BUILD_DIR/distribution"
        print "Which version to delete?\nINPUT:"
        read ver
        if ! [[ $ver =~ $RE ]] ; then
                print "Invalid input!"
                exit 1;
        fi
	find "$HOME/$BUILD_DIR/distribution" -maxdepth 1 -type d -name $ver|xargs rm -rf
}

disp_build()
{
	print "Below are the versions present in build directory:"
	ls -1 "$HOME/$BUILD_DIR/build/64/trace/products/lib"|grep libmpr_ratingVariable|cut -f1 -d'.'|rev|cut -d'_' -f1|rev
	print "Which version to delete?\nINPUT:"
	read ver
	if ! [[ $ver =~ $RE ]] ; then
		print "Invalid input!"
		exit 1;
	fi
	find "$HOME/$BUILD_DIR/build/64/trace/products/lib" -name "*$ver*"|xargs rm
}

#Main execution starts from here
menu
