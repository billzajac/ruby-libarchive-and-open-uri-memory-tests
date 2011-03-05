#!/usr/bin/ruby

require 'open-uri'
require 'rubygems'
require 'libarchive'

#-------------------------
# Wget a binary file and untar and unbzip it (not inline)
# Poor memory utilization
#-------------------------

uri = ARGV[0]

if not (uri)
  puts "Please enter a URI to fetch as the first argument"
  exit 1
end

local_file = File.basename(uri)

puts "Downloading to file: #{local_file}"

open(uri, 'rb') do |uri_data|
  File.open(local_file, 'wb') do |file|
    file.write(uri_data.read)
  end
end

puts "Untarring..."

Archive.read_open_filename(local_file) do |ar|
  while (entry = ar.next_header)
    file_name = entry.pathname
    puts "WRITING: #{file_name}"
    File.open(file_name, 'wb') do |file|
      ar.read_data(1024) do |x|
        file << x
      end
    end
  end
end
