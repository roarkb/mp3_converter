#!/usr/bin/ruby -w

require "find"
require "helper"

abort "USAGE: '#{$0} <path to music directory>'" unless ARGV.first

FORMATS = %w[ aif aiff wav WAV ] # add the formats you want to retrieve
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
