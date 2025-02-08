#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require "tempfile"

#
#  BSのスロットのずれを実際に受信して、確認する。
#
class BScorrection

  def initialize( recpt1Cmd, recTime )
    @Recpt1Cmd = recpt1Cmd
    @RecTime   = recTime
  end
  
  def scan( chList )

    def sub( bsch )
      ret = []
      Tempfile.open("chscan_") do |f|
        f.close()
        File.open( f.path, "w" ) {} # zero reset
        cmd = [ @Recpt1Cmd, bsch, @RecTime.to_s, f.path ]
        pid = spawn( *cmd ,:out => :err, :err=> "/dev/null" )
        Process.waitpid( pid )
        if test( ?f, f.path )
          ret = getTSID( f.path )
        end
        f.unlink()
        return ret
      end
    end
      
    # recpt1 がパスにあるか？
    found = false
    ENV["PATH"].split(/:/).each do |p|
      if test( ?f, File.join( p, @Recpt1Cmd ))
        found = true
        break
      end
    end
    if found == false
      puts("Error: #{@Recpt1Cmd} が見つかりません。")
      exit
    end

    hist = {}                   # 重複防止のための履歴
    ret = {}
    chList.sort do |a,b|
      if a.tp2 == b.tp2
        a.slot <=> b.slot
      else
        a.tp2 <=> b.tp2
      end
    end.each do |chd|
      if chd.band == "BS"
        bsch = sprintf("%s_%d",chd.tp, chd.slot )
        if hist[ bsch ] == nil
          tsID = chd.tsid
          name = chd.name.gsub(/　/," ").mb_ljust( 20 )
          r = sub( bsch )
          if r.include?( tsID )
            STDERR.printf("%-8s %s %6d  %s\n",bsch, name, tsID, "○" )
          else
            result = "not found"
            ( chd.slot - 1).downto( 0 ) do |slot|
              bsch2 = sprintf("%s_%d",chd.tp, slot )
              r = sub( bsch2 )
              if r.include?( tsID )
                ret[ bsch ] = bsch2
                result = bsch2
                break
              end
            end
            STDERR.printf("%-8s %s %6d  %s -> %s\n",bsch, name, tsID, "×", result )
          end
          hist[ bsch ] = true
        end
      end
    end
    return ret
  end

  #
  #  TSファイルから transport_stream_id を取得する。
  #
  def getTSID( fname )

    tsf = TSfile.new
    tsf.open( fname )
    ts = TS.new
    tsid = {}
    loop do
      break if ( bs = tsf.getTsPacket()) == nil 
      
      tmp = ts.parse( bs )
      tsid[ tmp ] = 1 if tmp != nil
    end
    return tsid.keys
  end

  #
  #   BS slot 補正用データの出力
  #
  def write_convTable( fname, convTable )
    File.open( fname, "w" ) do |fp|
      fp.puts("#\n#   raspirec 向け recpt1 使用時の BS slot 補正データ\n#")
      fp.puts("\n")
      if convTable != nil and convTable.size > 0
        fp.puts("ExtraPatch = {")
        convTable.each_pair do |k,v|
          fp.printf("    \"%s\" => \"%s\",\n",k,v)
        end
        fp.puts("}")
      else
        fp.puts("# 補正なし")
      end
    end
  end
  
end


#
#  MPEG-2 TSヘッダ
#
class TS

  attr_accessor :sb             #syncByte
  attr_accessor :tei            #transport_error_indicator,
  attr_accessor :pusi           #payload_unit_start_indicator,
  attr_accessor :tp             #transport_priority,
  attr_accessor :pid            #pid,
  attr_accessor :tsc            #transport_scrambling_control,
  attr_accessor :afc            #adaptation_field_control,
  attr_accessor :cc             #continuity_control

  def initialize( str = nil)
    parse(str) if str != nil
  end

  def parse(str)
    a = str.getbyte(0)
    b = str.getbyte(1)
    c = str.getbyte(2)
    @pid  = (( b & 0x1f ) << 8 ) + c

    if @pid == 0x00             # SDT
      tsId = ( str.getbyte(8) << 8 ) + str.getbyte(9)
      return tsId
    else
      return nil
    end
  end
end 


class TSfile

  @@syncByte = 0x47
  @@packetSize = 188
  
  def initialize(  )
    @io = nil
    @buff = []
  end
  
  
  def open( fname )
    #
    #  0x47 を探す
    #
    @io = File.open( fname )
    @fname = fname
    
    offset = nil
    bs = @io.read( 1024 ).bytes
    bs.each_index do |i|
      if bs[i] == @@syncByte
        if bs[i+@@packetSize] == @@syncByte
          if bs[i+(@@packetSize * 2 )] == @@syncByte
            #printf("found %d %x %x\n",i, bs[i], bs[i+@@packetSize])
            offset = i
            break
          end
        end
      end
    end
    if offset != nil
      @io.seek( offset, IO::SEEK_SET )
    else
      raise "can't found syncByte"
    end

    @io
  end

  #
  #  TS パケット取得
  #
  def getTsPacket()

    raise if @io == nil

    if @buff.size == 0
      s = @io.read( @@packetSize * 32 )
      if s != nil
        n = 0
        loop do
          r = s.slice(n,@@packetSize )
          break if r == nil or r == ""
          n += @@packetSize
          @buff << r
        end
        
      end
    end
    return nil if @buff.size == 0
    return @buff.shift()
  end
  
end

