module Meme

  module Parser
    
    class Oathmeal < Meme::Parser::Base
    	
      def get_meme(url)
        page = @agent.get "#{@url}#{url}"
        
      end

      def read_page page
        meme = []
        meme_on_page = page.search("#comics > #feed_items > li > .bg_comic")
        meme_on_page.each do |d|
          ameme = Hash.new
          
          ameme[:info] = Hash.new 
          ameme[:info][:share] = Hash.new
          ameme[:info][:comment] = 0
          ameme[:info][:like] = 0
          ameme[:info][:share][:facebook] = 0
          ameme[:info][:share][:twitter] = 0

          d.css("h4").each do |node|
            ameme[:title] = node.children.to_s
          end
          
          d.css("a").each do |node|
            ameme[:href] = node['href']
          end
  
          meme.push(ameme) 
        end
        meme
      end

      def fetch(section, start_id=0, end_id=0, quantity=10)
        url = "#{@url}comics" 
        url = "#{@url}comics_pg/page:#{section}" unless 1 == section.to_i   
        puts url
        page = @agent.get url
        #puts page.inspect
        self.read_page(page)
      end

      def comment_url meme_id
        "https://www.facebook.com/plugins/comments.php?api_key=326365540733523&locale=en_US&sdk=joey&channel_url=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D18%23cb%3Df3bf10e44938bba%26origin%3Dhttp%253A%252F%252Ffunnymama.com%252Ff28e648bae2eb96%26domain%3Dfunnymama.com%26relation%3Dparent.parent&numposts=10&width=320&href=http%3A%2F%2Ffunnymama.com%2Fpost%2F#{meme_id}"
      end

      private 
        def get_meme_id post_url
          post_url.sub!('/post/','').to_i
        end

        def set_resource 
          @url = 'http://theoatmeal.com/' #assume funny mama for now
        end

        def build_photo_url photo
          return photo.gsub("_460x.jpg", '_600x.jpg')
        end

        def build_post_url id
          "#{@url}/post/#{id}"
        end

    end 
    
  end 

end