## stz 版 recpt1 への適用

recpt1(stz版) にも適用可能です。


## 実行方法

1. mkChConvTable.rb があるディレクトリに移動し --recpt1 付きで実行する。
```
ruby mkChConvTable.rb --recpt1 *.json > ch_conv_table_pt1.h
```

1. 作業ディレクトリに移動して、下記のコマンドを実行
```
% git clone https://github.com/stz2012/recpt1.git .
% cd recpt1
% cp (1)のディレクトリ/ch_conv_table_pt1.h .
% patch -p1 < (1)のディレクトリ/Misc/patch4recpt1.txt
```

1. 後は普通にコンパイル
```
% ./autogen.sh
% ./configure --enable-b25
% make
```
