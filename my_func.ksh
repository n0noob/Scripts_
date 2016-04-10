#!/bin/env ksh



bounce()
{
    if [[ -n $(psutc) ]]
    then
        kill -9 $(psutc|grep ES1008|awk '{print $2}'|head -1)
	sleep 1;
	runES1
        psutc
    else
	print "\033[1;31m ES was not up. Starting now! \033[m"
        runES1
    fi
}

aprES8()
{
    cd $ABP_APR_ROOT/log/ES1008/$(ls -t $ABP_APR_ROOT/log/ES1008/ |head -1)
}

buildLOGS()
{
    cd
    cd ~/$(ls -1S|grep IC_ |head -1)/logs    
}

checkES8()
{
	while true; 
	do 
		if [[ -z $(grep running *inner*) ]]; then
			print ". "
		fi
		grep running *;
		if [[ -z $(psutc) ]]; then
			print "\033[1;31m======================\033[m"
		        print "\033[1;31m    FATA!!   \033[m"
			print "\033[1;31m======================\033[m"
		        break
		fi

		sleep 1;
	done
}
