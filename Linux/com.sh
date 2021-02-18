#! /bin/bash

for i in a b c d e f g h i j k l m n o p q r s t u v w x y z
do

	ls /bin | grep -i '^'$i >> command_start_with_$i.txt
done 
