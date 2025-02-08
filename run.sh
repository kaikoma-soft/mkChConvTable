#!/bin/sh

time="600"

if [ -d "/dev/dvb/adapter0" ]
then
    PROG="recdvb"
    Opt=""
else
    PROG="recpt1"
    Opt="--scan"
fi
echo "$PROG $Opt"
    
for ch in BS15_0 CS4 CS2
do
    if [ ! -f Json/${ch}.json ]
    then
        $PROG --sid epg $ch $time - | epgdump json - Json/${ch}.json
    fi
done

ruby mkChConvTable.rb $Opt -d Output Json/*.json 
