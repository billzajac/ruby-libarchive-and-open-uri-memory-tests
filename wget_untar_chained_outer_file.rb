#!/usr/bin/ruby

require 'open-uri'
require 'rubygems'
require 'libarchive'

#-------------------------
# Wget a binary file and untar and unbzip it inline
# Uses roughly 1x the memory of the downloaded file
#-------------------------

uri = ARGV[0]

if not (uri)
  puts "Please enter a URI to fetch as the first argument"
  exit 1
end

def show_mem()
  puts Time.new.to_s + " -- MB: " + (`ps -o rss= -p #{$$}`.to_f / 1024).to_i.to_s
end

show_mem()
open(uri, 'rb') do |uri_data|
  Archive.read_open_memory(uri_data.read) do |ar|
    while (entry = ar.next_header)
      file_name = entry.pathname
      puts "WRITING: #{file_name}"
      show_mem()
      file = File.open(file_name, 'wb')
      ar.read_data(1024) do |x|
        file << x
      end
      file.close
      show_mem()
    end
  end
end

show_mem()
