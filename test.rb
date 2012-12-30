# encoding: utf-8
#require "bundler/setup"
$: << File.dirname(__FILE__)

require 'json'
require 'haml'
require 'net/http'
require 'uri'
require 'open-uri'
require 'less'
require 'rest-client'
require 'mongo'
require 'mongoid'
require 'rack-flash'
require 'mechanize'
require 'meme/parser'


puts "START TO TEST funnymama"
begin
  #section = '9gag'
  section = 'funnymama'
  parser = Meme::Parser.new(section)
  meme = parser.fetch 1
  puts meme.to_json
rescue Exception => e 
  raise e
end


# puts "START TO TEST 9gaga"
# begin
#   section = '9gag'
#   parser = Meme::Parser.new(section)
#   meme = parser.fetch 1
#   meme = parser.fetch 2, 6094471, 6098657, 10
#   puts meme.to_json
# rescue Exception => e 
#   raise e
# end

# puts "START TO TEST haivl"
# begin
#   section = 'haivl'
#   parser = Meme::Parser.new(section)
#   meme = parser.fetch 1
#   meme = parser.fetch 7  
#   #meme = parser.fetch 2, 6094471, 6098657, 10
#   puts meme.to_json
# rescue Exception => e 
#   raise e
# end