#!/usr/bin/env ruby
# encoding: UTF-8

$VERBOSE = true

$: << File.dirname(__FILE__)
$: << File.expand_path("../../ext")
$: << File.expand_path("../../lib")

require 'oj'

$json = %|
{
  "data" : [ {
    "action" : "login",
    "event" : "user",
    "field" : "login",
    "value" : "foobar",
    "info" : "Authenticated \\"Foo Bar\\"",
    "id" : "585929918297f2740ed9f5f0",
    "_metadata" : {
      "version" : "1"
    },
    "timestamp" : "2016-12-20T07:52:33",
    "key_id" : "4"
  } ],
  "info" : {
    "view" : "partial",
    "limit" : 500,
    "offset" : 2000,
    "results" : 500,
    "ordering" : "timestamp desc,id",
    "previous" : "https://api.server.com/some/path/event?calculate_total=false&draft=base&order_by=timestamp_desc&order_by=id&subdraft=none&offset=1500&limit=500",
    "next" : "https://api.server.com/some/path/event?calculate_total=false&draft=base&order_by=timestamp_desc&order_by=id&subdraft=none&offset=2500&limit=500",
    "draft" : "base",
    "subdraft" : "none",
    "total_results" : 100000
  }
}
|

$cnt = 0
  
while true
  before = GC.count
  data = Oj.load($json, symbol_keys: true, mode: :strict)
  puts " did a GC in Oj #{GC.count} - #{$cnt}" if before != GC.count
  raise "FAILED" if data[:data].any? { |e| e.empty? }
  $cnt += 1
  print "\r #{$cnt}" if 0 == ($cnt % 10000)
end
