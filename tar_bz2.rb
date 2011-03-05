#!/usr/bin/ruby

require 'rubygems'
require 'libarchive'
require File.join(File.dirname(__FILE__), 'profile_tools')

pt = ProfileTools.new

#-------------------------
# Bzip a file
#-------------------------

fn = ARGV[0]

if not (File.exists?(fn))
  puts "File does not exist: " + fn
  exit 1
end

pt.show_mem("Have not started yet")
Archive.write_open_filename("#{fn}.tar.bz2", Archive::COMPRESSION_BZIP2, Archive::FORMAT_TAR) do |ar|
  pt.show_mem("Opened archive for writing: #{fn}.tar.bz2")
  ar.new_entry do |entry|
    pt.show_mem("About to add entry: #{fn}")
    entry.copy_stat(fn)
    entry.pathname = fn
    ar.write_header(entry)

    open(fn) do |f|
      pt.show_mem("Opened file: #{fn}")
      ar.write_data { f.read(1024) }
    end
    pt.show_mem("Closed file: #{fn}")
  end
  pt.show_mem("Finished with entry: #{fn}")
end
pt.show_mem("Done")
