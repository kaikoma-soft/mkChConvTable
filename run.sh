#!/bin/sh

time="300"

for ch in BS15_0 CS4 CS2
do
    if [ ! -f ${ch}.json ]
    then
        recdvb --sid epg $ch $time - |  epgdump json - ${ch}.json
    fi
done

ruby mkChConvTable.rb --recdvb *.json > ch_conv_table_dvb.h
ruby mkChConvTable.rb --recpt1 *.json > ch_conv_table_pt1.h

    
