#!/usr/bin/ruby -w

require "helper"

count = validate

print "This will delete #{count} files.  Do you wish to proceed? (y/n)> "

if gets.chomp == "y"
  File.readlines(TXT_FILE).each { |e| delete(e.chomp) }
  puts "complete"
else
  puts "aborted"
end
