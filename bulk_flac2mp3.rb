#!/usr/bin/env ruby

# lame does not have native flac support 
# so i wrote this wrapper for flac2mp3.sh

SONGS = "uncompressed.txt"

File.open(SONGS, "r").each do |e|
  flac = e.chomp
  mp3 = flac.gsub(/(flac)$/, "mp3")
 
  puts "converting: #{flac}\nto:         #{mp3}\n\n"
 
  system(%Q{./flac2mp3.sh 0 "#{flac}" "#{mp3}" mtime})

  if File.exists?(mp3)
    puts "removing: #{flac}..."
    system(%Q{rm "#{flac}"})
  else
    puts "skipping for now..."
  end
end
