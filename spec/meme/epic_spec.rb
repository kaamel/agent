require 'yaml'
require_relative '../../meme/parser'

describe Meme::Parser do
	before :each do
		@parser = Meme::Parser.create("epic")
    end

	describe "#new" do
    	it "takes 1 parameter as Meme source and returns a Meme::Parser object" do
        	@parser.should be_an_instance_of Meme::Parser 
	    end
	end

	describe "#fetch" do
		it "fetch resource from EPIC.VN and should return an array of a hash with :url and :src" do
			begin
			    meme = @parser.fetch(1, 0, 0, 10)
		  	rescue Exception => e 
			    flash[:notice] = "Invalid URL"
			    #redirect '/error'
			    raise e
		  	end	
		  	pp meme
		  	meme.count.should eql(8)
		end
	end

end
