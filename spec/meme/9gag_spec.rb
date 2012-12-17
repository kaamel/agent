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
		it "fetch resource 9gag and should return an array of a hash with :url and :src" do
			meme = @parser.fetch(1, 0, 0, 10)
		  	meme.should have(10).Hash
		end
	end

end
