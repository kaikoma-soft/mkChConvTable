

OutDir   = "."                      # 出力Dir
OutFname = {                        # 出力ファイル名
  :recdvb => "ch_conv_table_dvb.h", # recdvb 向け
  :recpt1 => "ch_conv_table_pt1.h", # recpt1 向け
  :scan   => "extra.rb",            # raspirec 向け BS スロット補正データ
}

RecTime    = 1                      # scan 時の録画時間

cmd = "recpt1"
if test(?d, "/dev/dvb/adapter0" )
  cmd = "recdvb"
end
Recpt1Cmd = cmd                 # scan 時のrecpt1 コマンド

