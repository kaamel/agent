require 'yaml'
require_relative '../../meme/parser'

describe Meme::Parser do
	before :each do
		@parser = Meme::Parser.new("LolHappen")		
	end

	describe "#new" do
    	it "takes 1 parameter as Meme source and returns a Meme::Parser object" do
        	@parser.should be_an_instance_of Meme::Parser 
	    end
	end

	describe "#fetch-9gag" do
		it "fetch resource 9gag and should return an array of a hash with :url and :src" do
			begin
			    meme = @parser.fetch(1, 0, 0, 10)
		  	rescue Exception => e 
			    flash[:notice] = "Invalid URL"
			    #redirect '/error'
			    raise e
		  	end	
		  	meme.count.should eql(8)
		end
	end

end
