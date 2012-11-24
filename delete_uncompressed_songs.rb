#!/usr/bin/ruby -w

require "helper"

count = validate

abort "no #{OUT_FILE} found" unless File.exist?(OUT_FILE)

def file_diff(file1, file2, diff_file)
  diff = `diff #{file1} #{file2}`
  
  if diff != ""
    fh = File.open(diff_file, "w")
    fh.puts diff
    fh.close
    abort "#{file1} and #{file2} do not match.  see #{diff_file}"
  end
end

file_diff(IN_FILE, OUT_FILE, "convert.diff")

print "This will delete #{count} files.  Do you wish to proceed? (y/n)> "

if gets.chomp == "y"
  f = "deleted.txt"
  fh = File.open(f, "w")

  File.readlines(IN_FILE).each do |e| 
    line = e.chomp
    system(%Q{rm "#{line}"})
    fh.puts line
  end

  fh.close
  file_diff(IN_FILE, f, "deleted.diff")
  puts "complete"
else
  puts "aborted"
end
