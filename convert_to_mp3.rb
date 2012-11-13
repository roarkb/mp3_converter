#!/usr/bin/ruby -w

require "rubygems"
require "taglib"
require "helper"

count = validate

puts "converting #{count} files to mp3...\n\n"

File.readlines(TXT_FILE).each do |e|
  p input = e.chomp
  p output = input.gsub(/\.[a-zA-Z]*$/, ".mp3")
  
  TagLib::FileRef.open(input) do |ref|
    p t = ref.tag
    system("lame -b 320 --tt \"#{t.title}\" --ta \"#{t.artist}\" --tl \"#{t.album}\" --tn \"#{t.track}\" \"#{input}\" \"#{output}\"")
  end
end

puts "complete"
