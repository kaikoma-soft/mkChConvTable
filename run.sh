#!/bin/sh

time="600"
#PROG="recdvb"
PROG="recpt1"

for ch in BS15_0 CS4 CS2
do
    if [ ! -f Json/${ch}.json ]
    then
        $PROG --sid epg $ch $time - | epgdump json - Json/${ch}.json
    fi
done

ruby mkChConvTable.rb --recdvb Json/*.json > ch_conv_table_dvb.h
ruby mkChConvTable.rb --recpt1 Json/*.json > ch_conv_table_pt1.h
