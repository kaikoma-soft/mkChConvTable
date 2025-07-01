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
git clone --depth 1 https://github.com/kaikoma-soft/mkChConvTable.git .
```

## 実行方法

mkChConvTable.rb があるディレクトリに移動し run.sh を実行する。
```
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
```

## オプションの説明


| オプション |      説明                             |
|------------|---------------------------------------|
| -d dir     | 出力Dirの指定(デフォルトはカレントディレクトリ)|
| --scan     | BSの slot 補正を行う。recpt1のみ (詳細は後述)        |

## 出力ファイル

|  ファイル名          |      説明       |
|----------------------|--------------------|
| ch_conv_table_dvb.h  | recdvb 用 チャンネル情報ファイル   |
| ch_conv_table_pt1.h  | recpt1 用   〃                     |
| bs_slot.rb           | raspirec 向け BS slot 補正ファイル |

* ファイル名は固定
* デフォルトではカレントディレクトリに出力するが、 -d オプションで変更可能。
* Output/ 以下に出力例があるので、そちらを参照して下さい。

## BS slot のズレ補正 (--scan)

recpt1 を px4_drv or pt1_drv で 使用する場合、スロットに空きがあると
EPG の値と指定する値にずれが生じることがある。<br>
それを補正するために recpt1 で実際にチューニングして得られたTS ストリームの
transport_stream_id が、EPGの値と一致するかチェックする。
<br>
もし、一致しない場合は、slot をデクリメントして、一致するスロットを探す。
<br>
ズレがある場合、recpt1向けのデータは、ズレを修正したものを出力する。
(recdvb はずれないので、そのまま。)

* 実行例 ( BS15_3 がずれて BS15_2 なっている場合 )
    ```
    BS1_0    ＢＳ朝日１            16400  ○
    BS1_1    ＢＳ－ＴＢＳ          16401  ○
    BS1_2    ＢＳテレ東            16402  ○
    ...
    BS15_0   ＮＨＫ ＢＳ           16625  ○
    BS15_1   ＢＳ１０スターｃｈ    16626  ○
    BS15_3   ＢＳ１０              18675  × -> BS15_2
    BS19_0   Ｊ ＳＰＯＲＴＳ ４    18224  ○
    ...
    ```


## 利用方法

* 生成したチャンネル情報ファイルを利用出来るように改造した
  recdvb,recpt1 を用意しました。

    |           | フォーク元      |  URL                                   |
    |-----------|-----------------|----------------------------------------|
    | recpt1    | stz2012/recpt1  | https://github.com/kaikoma-soft/recdvb |
    | recdvb    | dogeel/recdvb   | https://github.com/kaikoma-soft/recpt1 |

  チャンネル情報に変更があった場合は、こちらの ch_conv_table_(dvb|pt1).h
  を上書きすれば直ぐに対応出来ます。

* ちなみに、recdvb は、チャンネル情報ファイルに無いチャンネルを選局出来ないので
  放送局が新規追加の場合は、修正が必須です。<br>
  それに対して recpt1 は BSXX_X 形式の選局は可能なので、修正は任意です。
  (-help の放送局一覧に出ないぐらい。)

## 動作確認環境

|   項目       |       値            |
|--------------|---------------------|
| 機種         |  AMD Ryzen 7 2700 + MEM 16G |
| OS           |  Ubuntu 24.04.1 LTS |
| チューナー + ドライバー |  DTV02A-4TS-P + px4_drv + recpt1
|         〃              |  PT2 + pt1_drv + recpt1
|         〃              |  PT2 + earth_pt1 + recdvb



## 変更履歴
 * 2022/03/09 出力例に BSに 下記の 3局追加
   * BSよしもと(BS23_1)
   * BSJapanext(BS23_2)
   * BS松竹東急(BS23_3)

 * 2025/01/11
   BS10 の開局に伴い、recpt1 のスロットのズレを補正する --extra オプションを追加
   * BSJapanext(BS23_2) -> BS10(BS15_3 recpt1 は BS15_2 )
   * スターチャンネル   -> BS10スターch(BS15_1)

 * 2025/02/08    Ver 1.1.0
   * 機能追加
     * --scan オプションを新設。
       これにより、BSのスロットのズレを検出し補正する。
       実行には recpt1 を実行できる環境が必要。
       また、raspirec 向けの補正データをファイル出力する。
     * -d オプションの追加
     * raspirec 向けのスロット補正データを出力する。
   * 仕様変更
     * 従来は結果は標準出力に出力していたが、ファイルに直接出力するように変更。
     * 一度に recpt1,recdvd 向けのファイルを出力するように。(--recpt1,--recdvd の廃止)

 * 2025/02/28    
    今ままで空きスロットが有っても、ズレが起きなかった下記の２局がずれる
    ようになった。(Outputのみ更新)

```
    ＢＳ１２トゥエルビ  BS9_2  => BS9_1
    ＢＳ松竹東急        BS23_3 => BS23_2
```

* 2025/07/01<br>
     局名変更(名称のみ)
```
     BS23_3    BS松竹東急     -> J：COM BS
     CS_321    スペシャプラス -> MusicJapan
```
     