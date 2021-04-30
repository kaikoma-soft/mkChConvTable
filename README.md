# mkChConvTable

## 目的

本プログラムは、
放送波の EPG データよりチャンネル情報を取得し、
recdvb 用のチャンネル情報のソースを生成することにより
 BS/CS 放送局の増減、トランポンダーの移動等が起きた時の
対応を容易にします。


## 実行に必要な環境

* BS/CS が受信出来るチューナーカード(PT2 等)
* チューナープログラム (recdvb 等)
* ruby   2.5.1 以上
* epgdump ( https://github.com/Piro77/epgdump を推奨 )

## インストール方法

作業ディレクトリに移動して、下記のコマンドを実行

```
% git clone https://github.com/kaikoma-soft/mkChConvTable.git .
```

## 実行方法

mkChConvTable.rb があるディレクトリに移動し run.sh を実行する。
```
time="120"

for ch in BS15_0 CS4 CS2
do
    if [ ! -f ${ch}.json ]
    then
        recdvb --sid epg $ch $time - |  epgdump json - ${ch}.json
    fi
done

ruby mkChConvTable.rb *.json > ch_conv_table.h
```

## 実行結果

OutputSample/ 以下に出力例があるので、そちらを参照。


## 動作確認環境

|   項目       |       値            |
|--------------|---------------------|
| 機種         |  AMD Ryzen 7 2700 + MEM 16G |
| OS           |  Ubuntu 20.04.2 LTS |
| TVチューナー |  PT2
| ドライバー   |  OS 付属 dvb
| チューナーソフト |  recdvb  Ver 1.2.1.1
