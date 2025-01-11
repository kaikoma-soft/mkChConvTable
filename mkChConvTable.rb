#!/usr/local/bin/ruby 
# -*- coding: utf-8 -*-

#
#   recdvb 用の pt1_dev.h 中の isdb_t_conv_table[] を出力する。
#

require 'optparse'
require 'json'

$opt = {
  :d => false,
  :type => :recdvb,
  :extra => false,
}

$pname   = File.basename( $0 )
$version = "1.0.1"

def usage()
    usageStr = <<"EOM"
Usage: #{$pname} [Options]  json-file...

  Options:
      --recdvb           recdvb用を生成(デフォルト)
      --recpt1           recpt1用を生成
      --extra            recpt1時に、スロットのズレを補正する。

#{$pname} ver #{$version}
EOM
    puts usageStr
    exit 1
end


OptionParser.new do |opt|
  opt.on('--recdvb') { $opt[:type] = :recdvb } # デフォルト
  opt.on('--recpt1') { $opt[:type] = :recpt1 }
  opt.on('--extra') { $opt[:extra] = true }
  opt.on('--help')   { usage() }
  opt.parse!(ARGV)
end


class ChData

  attr_reader   :id ,:tsid, :svid, :name, :tp, :slot, :band, :name2
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
  end
end

class MkChConvTable

  def initialize( argv )

    usage() if argv.size == 0
    
    @chList = []
    @svidList = {}
    @convTable = {}
    argv.each do |fname|
      if test( ?f, fname )
        readJson(fname, @chList, @svidList)
      end
    end

    if $opt[:type] == :recpt1
      if $opt[:extra] == true
        extra = "./extra.rb"
        if test( ?f, extra )
          require extra
          if Object.const_defined?(:ExtraPatch) == true
            if ExtraPatch.class == Hash
              ExtraPatch.each_pair do |k,v|
                @convTable[ k ] = v
              end
            end
          end
        end
      end
    end
    
    @bsTbl = []
    @csTbl = []
    bsFormat1 = "    { BS_%02d, CHTYPE_SATELLITE, %d, 0x%x, \"%d\"},  /* %s */"
    csFormat1 = "    { CS_%02d, CHTYPE_SATELLITE, 0, 0x%x, %s},  /* %s */"
    if $opt[:type] == :recpt1
      bsFormat1 = "    { BS_%02d, CHTYPE_SATELLITE, %d, \"%d\"},  /* %s */"
      csFormat1 = "    { CS_%02d, CHTYPE_SATELLITE, 0, %s},  /* %s */"
    end
      
    @chList.sort do|a,b|
      (a.tsid <=> b.tsid).nonzero? || a.svid <=> b.svid 
    end.each do |r|
      if r.band == "BS"
        tsid = r.tsid
        ch = r.tp.sub(/BS/,'').to_i
        if $opt[:type] == :recpt1
          slot = r.slot
          tmp = sprintf("%s_%d", r.tp, r.slot )
          if @convTable[ tmp ] != nil
            #pp "#{tmp} -> #{@convTable[ tmp ]}"
            if @convTable[ tmp ] =~ /BS(\d+)_(\d+)/
              slot = $2.to_i
            end
          end
          @bsTbl << sprintf( bsFormat1,ch, slot,r.svid,r.name2 )
        else
          @bsTbl << sprintf( bsFormat1,ch,r.slot,r.tsid,r.svid,r.name2 )
        end
      elsif r.band == "CS"
        ch = r.tp.sub(/CS/,'').to_i
        svid = sprintf("%-6s","\"#{r.svid}\"")
        if $opt[:type] == :recpt1
          @csTbl << sprintf(csFormat1, ch, svid,r.name2)
        else
          @csTbl << sprintf(csFormat1, ch,r.tsid,svid,r.name2)
        end
      end
    end

    print()

  end

  def cat(fname)
    path = "Template/" + fname
    if test( ?f, path )
      File.open( path ) do |fp|
        puts( fp.read )
      end
    else
      raise "file not found #{fname}"
    end
  end

  #
  #  結果出力
  #
  def print()

    headerFN = "dvb_header.txt"
    enderFN  = "dvb_ender.txt"
    csFN     = "dvb_cs.txt"
    if $opt[:type] == :recpt1
      enderFN  = "pt1_ender.txt"
      csFN     = "pt1_cs.txt"
    end
    
    cat( headerFN )
    @bsTbl.sort.each do |tmp|
      puts(tmp)
    end
    cat( csFN )
    @csTbl.sort.uniq.each do |tmp|
      puts(tmp)
    end
    cat( enderFN )

    puts("\nchar *helpChList[] = {")

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
    puts( bufB.join("\n") )
    puts("\t\"\",\n")
    puts( bufC.join("\n") )
    puts("\tNULL,\n};")
    now = Time.now.to_s
    puts("\n// created by mkChConvTable.rb (#{now})")
    puts("// BS = #{bufB.size}, CS = #{bufC.size}")

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

mcct = MkChConvTable.new( ARGV )



