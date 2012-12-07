require 'rubygems'
require 'mechanize'
# require 'mongo_mapper'
# #gem "mongoid", "~> 2.4"
# #gem "bson_ext", "~> 1.5"

# class Meme
# 	include MongoMapper::Document

#  	key :name, String
#  	key :file, String
# end

# if (ENV['MONGODB_URI']) 
#  	MongoMapper.setup({'production' => {'uri' => ENV['MONGODB_URI']}}, 'production')
# else
#  	MongoMapper.setup({'production' => {'uri' => 'mongodb://localhost/funnymama_dev'}}, 'production')
# end

def read_page page
	pics = page.search("article.post > .post-content > .post-img > a");
	id =0;
	pics.each do |d|
		p "#{d['href']}, #{d.children[1]['src']}"
		#puts d.inspect
	end
	id

	# article = page.search("article.post");# > .post-content > .post-img > a");
	# id =0
	# article.each do |d|
	# 	puts "Found article #{d['id']}"
	# 	#p "#{d['href']}, #{d.children[1]['src']}"
	# 	puts d.children[0]['href']
	# 	puts d.children[0].children[1]['src']
	# 	puts "#{d.children[2].text}"
	# 	puts "#{d.children[4].children[1].text} love #{d.children[4].children[3].text} comments"
	# 	id = d['id']
	# 	#puts d.inspect
	# end
	# id
end

def no_more page

end

agent = Mechanize.new

begin
	page = agent.get 'http://funnymama.com/'
rescue
	puts "Invalid URL"
	exit
end

i = 0;
stop_at_page = 4;
begin
	i = i+1
	p "Process page #{i}"
	id = read_page page
	page = agent.page.link_with(:text => "OLDER").click
	#puts id
	#page = agent.post 'http://funnymama.com/postlist', "id=#{id}&s=f&u=0&f=1&q="
	#puts page.inspect
end until i==stop_at_page 