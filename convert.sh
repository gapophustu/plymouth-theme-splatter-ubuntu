#!/bin/bash

k=0
for i in $(cat sizes)
do
    k=$(expr $k + 1)
    for j in $(ls -A splatter-ubuntu/ | grep "splatter_5" | sort -g)
    do
        convert splatter-ubuntu/$j -resize $i splatter-ubuntu/$(echo splatter_$(echo $k)_$(echo $j | cut -c12-))
    done
done
