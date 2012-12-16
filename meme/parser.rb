module Meme

  class Parser 

    def initialize source
      puts "initialize #{source}"
      @source = source
      @url = 'http://funnymama.com/' #assume funny mama for now  
      @agent = Mechanize.new 
    end

    def read_page page
      puts "read_page is not implmented for #{@source} yet"
    end

    def fetch section
      puts "fetch is not implemented for #{@source} yet" 
    end

  end

end
#Dir[File.dirname(__FILE__) + "/meme/parser/*.rb"].each { |f| require(f) }
Dir[File.dirname(__FILE__) + "/parser/*.rb"].each do |f|
  puts "Found file: #{f}. About to load it"
  require f
end