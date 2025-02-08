#!/usr/local/bin/ruby 
# -*- coding: utf-8 -*-

#
#   recdvb 用の pt1_dev.h 中の isdb_t_conv_table[] を出力する。
#

require 'optparse'
require 'json'
require_relative "const.rb"
require_relative "tsid.rb"


$opt = {
  :d      => false,
  :type   => :recdvb,
  :scan   => false,
  :outdir => OutDir,
}

$pname   = File.basename( $0 )
$version = "1.1.0"

def usage()
    usageStr = <<"EOM"
Usage: #{$pname} [Options]  json-file...

  Options:
      --scan             recpt1の BSスロットのズレを補正する。
      -d dir             出力先の指定

#{$pname} ver #{$version}
EOM
    puts usageStr
    exit 1
end


OptionParser.new do |opt|
  opt.on('-d dir','--dir dir')   {|v| $opt[:outdir] = v }
  opt.on('--scan')   { $opt[:scan] = true }
  opt.on('--help')   { usage() }
  opt.parse!(ARGV)
end


class ChData

  attr_reader   :id ,:tsid, :svid, :name, :tp, :slot, :band, :name2, :tp2
  def initialize( data )
    @id    = data["id"]
    @tsid  = data["transport_stream_id"]
    @svid  = data["service_id"]
    @name  = data["name"]
    @tp    = data["satelliteinfo"]["TP"]
    @slot  = data["satelliteinfo"]["SLOT"]
    @band  = case  @tp
             when /^BS/ then "BS"
             when /^CS/ then "CS"
             end
    @name2 = @name.tr('０-９ａ-ｚＡ-Ｚ　－','0-9a-zA-Z -')
    @tp2   = @tp.sub(/(BS|CS)/,"").to_i
  end
end

class MkChConvTable

  def initialize( argv )

    usage() if argv.size == 0

    # 出力先 Dir の確認
    unless test( ?d, $opt[:outdir] )
      puts("Error: 出力先のディレクトリ(#{$opt[:outdir]})が存在しません。")
      exit
    end
                       
    @chList = []
    @svidList = {}
    @convTable = {}

    #
    #  json の読み込み
    #
    argv.each do |fname|
      if test( ?f, fname )
        readJson(fname, @chList, @svidList)
      end
    end

    #
    # BS slot 補正の検出
    #
    fname = File.join( $opt[:outdir], OutFname[:scan] )
    File.unlink( fname ) if test( ?f, fname )
    if $opt[:scan] == true
      if Recpt1Cmd != "recpt1"
        printf("### 注意: 実行コマンドが recpt1 ではありません。 ###\n")
      end
      bsc = BScorrection.new( Recpt1Cmd, RecTime )
      @convTable = bsc.scan( @chList )
      bsc.write_convTable( fname, @convTable )
    end

    #
    #  ファイル出力
    #
    write( :recdvb )
    write( :recpt1 )

  end

  def cat(fname, fw )
    path = "Template/" + fname
    if test( ?f, path )
      File.open( path ) do |fp|
        fw.puts( fp.read )
      end
    else
      raise "file not found #{fname}"
    end
  end

  
  #
  #  結果出力
  #
  def write( type )

    bsTbl = []
    csTbl = []
    if type == :recdvb
      bsFormat1 = "    { BS_%02d, CHTYPE_SATELLITE, %d, 0x%x, \"%d\"},  /* %s */"
      csFormat1 = "    { CS_%02d, CHTYPE_SATELLITE, 0, 0x%x, %s},  /* %s */"
    elsif type == :recpt1
      bsFormat1 = "    { BS_%02d, CHTYPE_SATELLITE, %d, \"%d\"},  /* %s */"
      csFormat1 = "    { CS_%02d, CHTYPE_SATELLITE, 0, %s},  /* %s */"
    else
      raise
    end
    outFname = File.join( $opt[:outdir], OutFname[ type ] )
      
    @chList.sort do|a,b|
      (a.tsid <=> b.tsid).nonzero? || a.svid <=> b.svid 
    end.each do |r|
      if r.band == "BS"
        tsid = r.tsid
        ch = r.tp2
        if type == :recpt1
          slot = r.slot
          tmp = sprintf("%s_%d", r.tp, r.slot )
          if @convTable[ tmp ] != nil
            if @convTable[ tmp ] =~ /BS(\d+)_(\d+)/
              slot = $2.to_i
            end
          end
          bsTbl << sprintf( bsFormat1,ch, slot,r.svid,r.name2 )
        else
          bsTbl << sprintf( bsFormat1,ch,r.slot,r.tsid,r.svid,r.name2 )
        end
      elsif r.band == "CS"
        ch = r.tp.sub(/CS/,'').to_i
        svid = sprintf("%-6s","\"#{r.svid}\"")
        if type == :recpt1
          csTbl << sprintf(csFormat1, ch, svid,r.name2)
        else
          csTbl << sprintf(csFormat1, ch,r.tsid,svid,r.name2)
        end
      end
    end

    headerFN = "header.txt"
    if type == :recdvb
      enderFN  = "dvb_ender.txt"
      csFN     = "dvb_cs.txt"
    elsif type == :recpt1
      enderFN  = "pt1_ender.txt"
      csFN     = "pt1_cs.txt"
    end

    File.open( outFname, "w") do |fp|
      cat( headerFN, fp )
      bsTbl.sort.each do |tmp|
        fp.puts(tmp)
      end
      cat( csFN, fp )
      csTbl.sort.uniq.each do |tmp|
        fp.puts(tmp)
      end
      cat( enderFN, fp )

      fp.puts("\nchar *helpChList[] = {")

      bufB = []
      bufC = []
      format = "\t\"%3d ch : %s\","
    
      chList2 = @chList.sort do|a,b|
        a.svid <=> b.svid
      end.each do |r|
        if r.band == "BS"
          bufB << sprintf( format, r.svid, r.name2 )
        elsif r.band == "CS"
          bufC << sprintf( format, r.svid, r.name2 )
        end
      end
      fp.puts( bufB.join("\n") )
      fp.puts("\t\"\",\n")
      fp.puts( bufC.join("\n") )
      fp.puts("\tNULL,\n};")
      now = Time.now.to_s
      fp.puts("\n// created by mkChConvTable.rb (#{now})")
      fp.puts("// BS = #{bufB.size}, CS = #{bufC.size}")
    end
  end
  
  #
  #  json ファイルの読み込み
  #
  def readJson( fname, chList, svidList )

    File.open( fname, "r" ) do |fp|
      str = fp.read
      data = JSON.parse(str)
      if data == nil or data.size == 0
        return false
      end
      data.each do |d1|
        tmp = ChData.new( d1 )
        svidList[ tmp.band ] ||= {}
        if svidList[ tmp.band ][ tmp.svid ] == nil
          chList << tmp
          svidList[ tmp.band ][ tmp.svid ] = true
        end
      end
    end
    true
  end

  
end

class String
  def mb_ljust(width, padding=' ')
    output_width = each_char.map{|c| c.bytesize == 1 ? 1 : 2}.reduce(0, &:+)
    padding_size = [0, width - output_width].max
    self + padding * padding_size
  end
end


mcct = MkChConvTable.new( ARGV )



