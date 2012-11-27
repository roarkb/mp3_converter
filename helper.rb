#!/usr/bin/ruby -w

IN_FILE = "uncompressed.txt"

def validate
  if File.exist?(IN_FILE)
    count = `wc -l #{IN_FILE}`.to_i
  else
    count = 0
  end

  abort "no files found" if count == 0
  count
end
