require 'pathname'
module Meme

  class Parser 

    def initialize source
      puts "initialize #{source}"
      @source = source
      @agent = Mechanize.new 
      f = File.dirname(__FILE__) + "/parser/#{source}.rb"
      require(f) if Pathname.new(f).exist? 
      set_resource
    end

    def read_page page
      puts "read_page is not implmented for #{@source} yet"
    end

    def fetch section
      puts "fetch is not implemented for #{@source} yet" 
    end
    
    private 
    
    def set_resource 
      puts "Implement some resouce for specified memesite here"
    end

  end

end
#Dir[File.dirname(__FILE__) + "/meme/parser/*.rb"].each { |f| require(f) }
#Dir[File.dirname(__FILE__) + "/parser/*.rb"].each do |f|
#  puts "Found file: #{f}. About to load it"
#  require f
#end