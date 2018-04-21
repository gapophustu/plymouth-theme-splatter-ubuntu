#!/bin/bash

k=0

if [[ ! -f splatter-ubuntu/shutdown_5_0.png ]]
then
    cp -a splatter-ubuntu.png splatter-ubuntu/shutdown_5_0.png
fi

convert splatter-ubuntu.png -alpha extract mask.png
for j in $(ls -A | grep "shutdown_" | sort -g)
do
    output=$(echo splatter-ubuntu/$(echo shutdown_5_$(echo $j | cut -c10-)))
    if [[ ! -f $output ]]
    then
        convert mask.png $j -composite temp.png
        convert splatter-ubuntu.png temp.png -alpha Off -compose CopyOpacity -composite $output
    fi
done
rm mask.png temp.png

for i in $(cat sizes)
do
    k=$(expr $k + 1)
    for j in $(ls -A splatter-ubuntu/ | grep "splatter_5" | sort -g)
    do
        output=$(echo splatter-ubuntu/$(echo splatter_$(echo $k)_$(echo $j | cut -c12-)))
        if [[ ! -f $output ]]
        then
            convert splatter-ubuntu/$j -resize $i $output
        fi
    done
    for j in $(ls -A splatter-ubuntu/ | grep "shutdown_5" | sort -g)
    do
        output=$(echo splatter-ubuntu/$(echo shutdown_$(echo $k)_$(echo $j | cut -c12-)))
        if [[ ! -f $output ]]
        then
            convert splatter-ubuntu/$j -resize $i $output
        fi
    done
done
