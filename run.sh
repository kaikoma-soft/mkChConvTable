#!/bin/sh

time="120"

for ch in BS15_0 CS4 CS2
do
    if [ ! -f ${ch}.json ]
    then
        recdvb --sid epg $ch $time - |  epgdump json - ${ch}.json
    fi
done

ruby mkChConvTable.rb *.json > ch_conv_table.h

    
