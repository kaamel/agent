require 'yaml'
require_relative '../meme/parser'

describe Meme::Parser do
	before :each do
		@parser = Meme::Parser.new("9gag")		
	end

	describe "#new" do
    	it "takes 1 parameter as Meme source and returns a Meme::Parser object" do
        	@parser.should be_an_instance_of Meme::Parser 
	    end
	end


end
