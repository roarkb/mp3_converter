#!/usr/bin/ruby -w

require "find"
require "helper"

abort "USAGE: '#{$0} <path to music directory>'" unless ARGV.first

FORMATS = %w[ aif aiff wav WAV ] # add the formats you want to retrieve
FH      = File.open(TXT_FILE, "w")

FORMATS.each do |format|
  Find.find(ARGV.first) do |path|
    if FileTest.directory?(path) == false
      if path.match(/\.#{format}$/)        
        unless path.match(/\/\._/) # ignore hidden files
          puts path
          FH.puts path
        end
      end
    end
  end
end

FH.close

puts "\n#{`wc -l #{TXT_FILE}`.to_i} files retrieved"
