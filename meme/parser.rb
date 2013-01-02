require 'json'
require 'net/http'
require 'uri'
require 'open-uri'
require 'rest-client'
require 'mechanize'
require 'pathname'

module Meme
      
  module Parser 
    
    def self.create(source)
      #v = Object.const_get("M").const_get("C").new
      v = Kernel.const_get("Meme").const_get("Parser").const_get(source.capitalize).new(source)
      #v = ("Meme").const_get("Parser").const_get(source.capitalize).new
      #v = ("Meme").const_get("Parser").const_get(source.capitalize).new
    end

    class Base
      def initialize source
        puts "initialize #{source}"
        @source = source
        @agent = Mechanize.new 
        f = File.dirname(__FILE__) + "/parser/#{source}.rb"
        #require(f) if Pathname.new(f).exist? 
        set_resource
      end

      def read_page page
        puts "read_page is not implmented for #{@source} yet"
      end

      def fetch section
        puts "fetch is not implemented for #{@source} yet" 
      end

      def comment_url
        puts "comment_url is not implemented for #{@source} yet" 
      end

      private 
      
      def set_resource 
        puts "Implement some resouce for specified memesite here"
      end

    end

  end
end

Dir[File.dirname(__FILE__) + "/meme/parser/*.rb"].each { |f| require(f) }
Dir[File.dirname(__FILE__) + "/parser/*.rb"].each do |f|
  puts "Found file: #{f}. About to load it"
  require f
end