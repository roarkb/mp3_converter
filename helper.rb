#!/usr/bin/ruby -w

TXT_FILE = "uncompressed.txt"

def validate
  if File.exist?(TXT_FILE)
    count = `wc -l #{TXT_FILE}`.to_i
  else
    count = 0
  end

  abort "no files found" if count == 0
  count
end
