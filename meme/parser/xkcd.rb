module Meme

  module Parser
    
    class Xkcd < Meme::Parser::Base
    	
      def read_page page
      
      end

      def fetch(section, start_id=0, end_id=0, quantity=10)
        meme = []
        memes = get_meme
        pp section
        section = Integer(section)
        quantity = Integer(quantity)
        memes = memes.slice((section-1)*quantity, quantity)
        memes.each do |node|
          ameme = Hash.new
          ameme[:info] = Hash.new 
          ameme[:info][:share] = Hash.new
          ameme[:info][:comment] = 0
          ameme[:info][:like] = 0
          ameme[:info][:share][:facebook] = 0
          ameme[:info][:share][:twitter] = 0

          ameme[:title] = node['title']          
          ameme[:id] = get_meme_id node['href']
          ameme[:src] = build_photo_url node.children.to_s
          ameme[:url] = build_post_url ameme[:id]
          meme.push ameme  
        end
        meme
      end

      def comment_url meme_id
        "https://www.facebook.com/plugins/comments.php?api_key=326365540733523&locale=en_US&sdk=joey&channel_url=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D18%23cb%3Df3bf10e44938bba%26origin%3Dhttp%253A%252F%252Ffunnymama.com%252Ff28e648bae2eb96%26domain%3Dfunnymama.com%26relation%3Dparent.parent&numposts=10&width=320&href=http%3A%2F%2Ffunnymama.com%2Fpost%2F#{meme_id}"
      end

      private 
        def get_meme
          url = "#{@url}archive"
          page = @agent.get url
          memes = page.search('#middleContainer > a')         
        end

        def get_meme_id post_url
          post_url.sub!('/','').to_i
        end

        def set_resource 
          @url = 'http://xkcd.com/' 
        end

        def build_photo_url photo
          photo.downcase!
          photo.gsub!(/[^a-zA-Z0-9_]/, '_')
          return 'http://imgs.xkcd.com/comics/' + photo + '.png'
        end

        def build_post_url id
          return "#{@url}#{id}"
        end

    end 
    
  end 

end