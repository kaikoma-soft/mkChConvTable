# mkChConvTable

## 目的

本プログラムは、
放送波の EPG データよりチャンネル情報を取得し、
recdvb/recpt1 用のチャンネル情報のソースを生成することにより
 BS/CS 放送局の増減、トランポンダーの移動等が起きた時の
対応を容易にします。


## 実行に必要な環境

* BS/CS が受信出来るチューナーカード(PT2 等)
* チューナープログラム (recdvb,recpt1 等)
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
time="300"
for ch in BS15_0 CS4 CS2
do
    if [ ! -f Json/${ch}.json ]
    then
        recdvb --sid epg $ch $time - | epgdump json - Json/${ch}.json
    fi
done

ruby mkChConvTable.rb --recdvb Json/*.json > ch_conv_table_dvb.h
ruby mkChConvTable.rb --recpt1 --extra Json/*.json > ch_conv_table_pt1.h
```

## 実行結果

Output/ 以下に出力例があるので、そちらを参照して下さい。

|  ファイル名          |      説明       |
|----------------------|--------------------|
| ch_conv_table_dvb.h  | recdvb 用 チャンネル情報ファイル|
| ch_conv_table_pt1.h  | recpt1 用   〃  |
 

## 利用方法

* 生成したチャンネル情報ファイルを利用出来る recdvb (dogeel/recdvb のfork)を
  https://github.com/kaikoma-soft/recdvb に用意しました。
  チャンネル情報に変更があった場合は、こちらの ch_conv_table_dvb.h
  を上書きすれば直ぐに対応出来ます。

* また stz2012/recpt1 のフォークで適用済みの
  https://github.com/kaikoma-soft/recpt1 も用意したので、そちらを利用する事も
  できます。
  
* ちなみに、recdvb は、チャンネル情報ファイルに無いチャンネルを選局出来ないので
  新規追加の場合は、修正が必須です。<br>
  それに対して recpt1 は BSXX_X 形式の選局は可能なので、修正は任意です。
  (-help の放送局一覧に出ないぐらい。)

## 動作確認環境

|   項目       |       値            |
|--------------|---------------------|
| 機種         |  AMD Ryzen 7 2700 + MEM 16G |
| OS           |  Ubuntu 24.04.1 LTS |
| TVチューナー |  DTV02A-4TS-P
| ドライバー   |  px4_drv
| チューナーソフト |  recpt1


## 変更履歴
 * 2022/03/09 出力例に BSに 下記の 3局追加
   * BSよしもと(BS23_1)
   * BSJapanext(BS23_2)
   * BS松竹東急(BS23_3)

 * 2025/01/11
   BS10 の開局に伴い、recpt1 のスロットのズレを補正する --extra オプションを追加
   * BSJapanext(BS23_2) -> BS10(BS15_3 recpt1 は BS15_2 )
   * スターチャンネル   -> BS10スターch(BS15_1)

