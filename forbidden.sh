#!/bin/bash

exe=$1
config=$2

if [ -f output ];
then
rm -rf output
fi

if [ -f $exe ];
then
:
else 
echo -e "file does not exist"
exit 1
fi

if [ -f $config ];
then
:
else 
echo -e "config does not exist"
exit 1
fi

nm -unj $exe | grep -v __ > output

if [ -s output ];
then 
:
else 
echo "Congratulations, no illegal functions"
fi

while read -r output_line
do
	fail=true
	while read -r line
	do
	if [ "$output_line" == "$line" ];
	then
	fail=false
	fi
	done < "$config"
	if [ $fail == true ];
	then 
	echo -e "FAIL: $output_line is illegal"
	fi
done < "output"

rm -rf output
if [ $fail == true ];
then 
exit 1
else
exit 0
fi
