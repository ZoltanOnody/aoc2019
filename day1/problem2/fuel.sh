#!/bin/bash

input=$1;
total=0;

while [ $input -gt 0 ];
do
	let tmp=$input/3-2;
	if [ $tmp -gt 0 ] 
	then
		let total+=$tmp
	fi
	input=$tmp
done

echo $total;
