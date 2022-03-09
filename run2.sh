#!/bin/sh

ruby mkChConvTable.rb --recdvb Json/*.json $HOME/raspirec/json/[BC]*.json > ch_conv_table_dvb.h
ruby mkChConvTable.rb --recpt1 Json/*.json $HOME/raspirec/json/[BC]*.json > ch_conv_table_pt1.h

