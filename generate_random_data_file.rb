#!/usr/bin/ruby

#-------------------------
# Generate random data
#-------------------------

fn = ARGV[0]

if not (fn)
  puts "Please enter a filename to create as the first argument"
  exit 1
end

if (File.exists?(fn))
  puts "ERROR: File already exists: " + fn
  exit 1
end

f = File.new(fn, "w+")

# 500 MB
file_size = 500 * 1024 * 1024

(1..file_size).each do |n|
  f.print((32 + rand(94)).chr)
end

f.close

