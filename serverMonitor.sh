#!/bin/bash
# Read the file line by line
subject=""

#cat server.txt |while read line
tag="safe"
filename='server.txt'
filelines=`cat $filename`
for line in $filelines ;
do
        # check if there are no blank lines
        if [ ! -z $line ]; then
                PINGCOUNT=2
                PING=$(ping -c $PINGCOUNT $line | grep received | cut -d ',' -f2 | cut -d ' ' -f2)
                if [ $PING -eq 0 ]; then
			tag="insafe"
                        #subject+= "Something wrong with the server: $line" 
                        # Or do send out mail
			c=" Something went wrong with the server: $line" 
			subject+="\n$c"
			
                else
                        echo "All good: $line"
                fi
        fi

done


if [ "$tag" == "unsafe" ];then
   echo -e $subject | mail -s "server status report"  "yourmail@gmail.com"
fi
echo -e  $subject




