#!/bin/sh

#
#  BS slot 補正のため、必ず recpt1 で実行する。
#
DRV="pt1_drv"
#DRV="px4_drv"

if [ -d "/dev/dvb/adapter0" ]
then
    sudo modprobe -r earth_pt1
    sudo modprobe $DRV
    sleep 1
    DVB="true"
fi

ruby mkChConvTable.rb --scan -d Output $HOME/raspirec/json/[BC]*.json

if [ "$DVB" = "true" ] 
then
    sudo modprobe -r $DRV
    sudo modprobe earth_pt1
fi
    


