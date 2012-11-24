#!/usr/bin/ruby -w

require "rubygems"
require "taglib"
require "helper"

count = validate

OUT_FH = File.open(OUT_FILE, "w")

puts "converting #{count} files to mp3...\n\n"

File.readlines(IN_FILE).each do |e|
  puts input = e.chomp
  output = input.gsub(/\.[a-zA-Z]*$/, ".mp3")
  
  TagLib::FileRef.open(input) do |ref|
    t = ref.tag
    system("lame -b 320 --tt \"#{t.title}\" --ta \"#{t.artist}\" --tl \"#{t.album}\" --tn \"#{t.track}\" \"#{input}\" \"#{output}\"")
  end
  
  puts
  OUT_FH.puts input
end

OUT_FH.close
puts "complete"
