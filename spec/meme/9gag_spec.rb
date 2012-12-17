require 'yaml'
require_relative '../../meme/parser'

describe Meme::Parser do
	before :each do
		@parser = Meme::Parser.new("9gag")		
	end

	describe "#new" do
    	it "takes 1 parameter as Meme source and returns a Meme::Parser object" do
        	@parser.should be_an_instance_of Meme::Parser 
	    end
	end

	describe "#fetch" do		
		it "contain 10 element" do
			@meme = @parser.fetch(1, 0, 0, 10)		
			@meme.should have(10).Hash
		end

		it "Some element must have :url and :src" do
			#pp @meme
  			@meme[0].should include(:url, :src)
		end
	end

end
