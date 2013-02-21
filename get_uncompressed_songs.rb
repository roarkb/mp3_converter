#!/usr/bin/ruby -w

require "find"

abort "USAGE: '#{$0} <full path to music directory>'" unless ARGV.first


# add the formats you want to retrieve
#FORMATS = %w[ aif aiff wav WAV ]
FORMATS = %w[ flac ]

IN_FILE = "uncompressed.txt"
IN_FH = File.open(IN_FILE, "w")

FORMATS.each do |format|
  Find.find(ARGV.first) do |path|
    if FileTest.directory?(path) == false
      if path.match(/\.#{format}$/)        
        unless path.match(/\/\._/) # ignore hidden files
          puts path
          IN_FH.puts path
        end
      end
    end
  end
end

IN_FH.close

puts "\n#{`wc -l #{IN_FILE}`.to_i} files retrieved"
