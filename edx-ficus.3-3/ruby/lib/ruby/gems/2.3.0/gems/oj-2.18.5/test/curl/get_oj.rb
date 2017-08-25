#!/usr/bin/env ruby
# encoding: UTF-8

$VERBOSE = true

$: << File.dirname(__FILE__)
$: << File.expand_path("../../ext")
$: << File.expand_path("../../lib")

require 'net/http'
require 'uri'
require 'oj'

$url = URI.parse("http://localhost:7660/data.json")

$cnt = 0

while true
  response = Net::HTTP.get_response($url)
  data = Oj.load(response.body, symbol_keys: true, mode: :strict)
  raise "FAILED" if data[:data].any? { |e| e.empty? }
  $cnt += 1
  print "\r #{$cnt}"
end
