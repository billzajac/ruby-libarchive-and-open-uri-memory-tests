#!/usr/bin/ruby

require 'open-uri'
require 'rubygems'
require 'libarchive'
require File.join(File.dirname(__FILE__), 'profile_tools')

pt = ProfileTools.new
#pt.mem_chunk_size = "Kb"
#pt.mem_decimals = 0

#-------------------------
# Wget a binary file and untar and unbzip it (not inline)
#-------------------------

uri = ARGV[0]

if not (uri)
  puts "Please enter a URI to fetch as the first argument"
  exit 1
end

local_file = File.basename(uri)

pt.show_mem("About to download to local file: #{local_file}")

file = File.open(local_file, 'wb')
pt.show_mem("Local file opened for writing: #{local_file}")
open(uri, 'rb') do |uri_data|
  pt.show_mem("URI opened: #{uri}")
  file.write(uri_data.read)
end
pt.show_mem("File written")
file.close
pt.show_mem("File closed")

GC.start # Force garbage collection
pt.show_mem("Forced garbage collection")


pt.show_mem("Untarring...")
Archive.read_open_filename(local_file) do |ar|
  pt.show_mem("Opened archive: #{local_file}")
  while (entry = ar.next_header)
    file_name = entry.pathname
    pt.show_mem("  Writing Untarred file: #{file_name}")
    file = File.open(file_name, 'wb')
    ar.read_data(1024) do |x|
      file << x
    end
    file.close
  end
end
pt.show_mem("Done")
