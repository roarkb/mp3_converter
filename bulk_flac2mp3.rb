#!/usr/bin/env ruby

# lame does not have native flac support 
# so i wrote this wrapper for flac2mp3.sh

File.open("uncompressed.txt", "r").each do |e|
  flac = e.chomp
  mp3 = flac.gsub(/(flac)$/, "mp3")
 
  puts "converting: #{flac}\nto:         #{mp3}\n\n"
 
  system(%Q{./flac2mp3.sh 0 '#{flac}' '#{mp3}' mtime})

  if File.exists?(mp3)
    system(%Q{rm '#{flac}'})
  else
    puts "skipping for now..."
  end
end
