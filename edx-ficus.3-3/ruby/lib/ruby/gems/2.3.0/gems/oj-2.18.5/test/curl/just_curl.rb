#!/usr/bin/env ruby
# encoding: UTF-8

#$VERBOSE = true

$: << File.dirname(__FILE__)
#$: << File.expand_path("../../../curb/ext")
#$: << File.expand_path("../../../curb/lib")

require 'curb'

$cnt = 0
$url = "localhost:7660/data.json"

begin
  while true
    before = GC.count
    curl = Curl::Easy.new($url)
    curl.ssl_verify_host = false
    curl.http_get
    if before != GC.count
      puts " did a GC in curl #{GC.count}"
      before = GC.count      
    end
    $cnt += 1
    print "\r #{$cnt}"
  end
rescue Exception => e
  puts "#{e.class}: #{e.message}"
  puts "url: #{$url}"
end
