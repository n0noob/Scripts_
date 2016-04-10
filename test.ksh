#!/bin/env ksh

if [[ -z $(psutc) ]]; then
	print "\033[1;31mHOHO\033[m"
        break
else
	print "Problem"
fi

