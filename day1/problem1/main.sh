
sum=0;
while read line; 
	do let "sum+=`./fuel.sh $line`"; 
done

echo $sum;