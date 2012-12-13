#!/usr/bin/ruby -w

require "rubygems"
require "taglib"

IN_FILE = "uncompressed.txt"

if File.exist?(IN_FILE)
  count = `wc -l #{IN_FILE}`.to_i
else
  count = 0
end

abort "no files found" if count == 0

LOG = "converted.log"
LOG_FH = File.open(LOG, "w")

puts "converting #{count} files to mp3...\n\n"

# TODO: some files with special characters get rejected
File.readlines(IN_FILE).each do |e|
  input = e.chomp
  output = input.gsub(/\.[a-zA-Z]*$/, ".mp3")
  puts "song: #{input}"
  
  TagLib::FileRef.open(input) do |ref|
    t = ref.tag
    system(%Q{lame -b 320 --tt "#{t.title}" --ta "#{t.artist}" --tl "#{t.album}" --tn "#{t.track}" "#{input}" "#{output}"})
  end
  
  if File.exists?(output)
    puts "created: #{output}"
    system(%Q{rm "#{input}"})
    puts "deleted: #{input}"
    LOG_FH.puts input
    LOG_FH.flush
  else
    abort "conversion failed on:\n#{input}"
  end

  puts
end

LOG_FH.close

diff = `diff #{IN_FILE} #{LOG}`

if diff != ""
  f = "converted.diff"
  fh = File.open(f, "w")
  fh.puts diff
  fh.close
  abort "#{IN_FILE} and #{LOG} do not match.  see #{f}"
else
  puts "complete"
end
