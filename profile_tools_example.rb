#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), 'profile_tools')

pt = ProfileTools.new
pt.mem_chunk_size = "Kb"   # Optional setting "Mb" is default
pt.mem_decimals = 0        # Optional setting

# Let's use 15.5 MB
size = 15 * 1024 * 1024
mem_var = ''

pt.show_mem("Have not started yet - should be base ruby size only")
(1..size).each do |n|
  mem_var << (32 + rand(94)).chr
end

pt.show_mem("Should have just added 15 Mb")
mem_var = ''
pt.show_mem("Did garbage collection happen automatically yet?")

GC.start # Force garbage collection
pt.show_mem("Just forced garbage collection")

