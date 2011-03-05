#!/usr/bin/ruby

require 'open-uri'
require File.join(File.dirname(__FILE__), 'profile_tools')

pt = ProfileTools.new

#-------------------------
# Wget a binary file
#-------------------------

uri = ARGV[0]

if not (uri)
  puts "Please enter a URI to fetch as the first argument"
  exit 1
end

pt.show_mem("Nothing started yet")
local_file = File.basename(uri)

File.open(local_file, 'wb') do |file|
  pt.show_mem("Local file opened for writing: #{local_file}")
    open(uri, 'rb') do |uri_data|
      pt.show_mem("URI opened: #{uri}")
      file.write(uri_data.read)
    end
    pt.show_mem("File written")
end
pt.show_mem("File closed")

