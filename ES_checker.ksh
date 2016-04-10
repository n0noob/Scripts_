#!/bin/env ksh

clear
echo "This script will notify you when ES is up!"

echo "Setting alias cdnew"
alias cdnew='cd $ABP_APR_ROOT/log/ES1008/$(ls -t $ABP_APR_ROOT/log/ES1008/ |head -1)'

if [[ $(alias cdnew) ]] 
then
	echo "cdnew is set"
else
	echo "cdnew is not set.....aborting!"
	exit 1
fi

cdnew
pwd
ls -ltr ..
echo "Is this correct path?(y/n)"
read opt

if [[ $opt == 'n' ]] 
then
	exit 1
elif [[ $opt == 'y' ]]
then
	echo "Continuing...."
else
	exit 1
fi

echo "Now checking if ES is up!"
#if [[ $(grep running *inner*) ]]
#	echo "ES is up"

flag=$(grep running *inner*)

while [[ -z $flag ]]
do
	echo "."
	sleep 1
    flag=$(grep running *inner*)
done

echo "ES is up now!"


