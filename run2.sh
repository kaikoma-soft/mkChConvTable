#!/bin/sh

ruby mkChConvTable.rb --recdvb $HOME/raspirec/json/[BC]*.json > ch_conv_table_dvb.h
ruby mkChConvTable.rb --recpt1 $HOME/raspirec/json/[BC]*.json > ch_conv_table_pt1.h

