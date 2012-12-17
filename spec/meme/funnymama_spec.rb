require 'yaml'
require_relative '../../meme/parser'

describe Meme::Parser do
	before :each do
		@parser = Meme::Parser.new("funnymama")		
	end

	describe "#new" do
    	it "takes 1 parameter as Meme source and returns a Meme::Parser object" do
        	@parser.should be_an_instance_of Meme::Parser 
	    end
	end

	describe "#fetch" do
		it "fetch resource funnymama and should return an array of a hash with :url and :src" do
			meme = @parser.fetch(1, 0, 0, 10)
		  	pp meme
		  	meme.count.should eql(10)
		  	#meme[0][:src].should 
		end
	end

end
