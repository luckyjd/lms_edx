#!/usr/bin/env ruby
# encoding: UTF-8

#$VERBOSE = true

$: << File.dirname(__FILE__)
$: << File.expand_path("../../ext")
$: << File.expand_path("../../lib")
$: << File.expand_path("../../../curb/ext")
$: << File.expand_path("../../../curb/lib")

require 'curb'
require 'oj'

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
=begin
    data = Oj.load(curl.body, symbol_keys: true, mode: :strict)
    puts " did a GC in Oj #{GC.count}" if before != GC.count

    if data[:data].nil? or data[:data].any? { |e| e.empty? }
      puts "body: #{curl.body}"
      raise "FAILED" 
    end
=end
    $cnt += 1
    print "\r #{$cnt}"
  end
rescue Exception => e
  puts "#{e.class}: #{e.message}"
  puts "url: #{$url}"
  #puts "data: #{data}"
  #puts "data[data]: #{data[:data]}"
end
