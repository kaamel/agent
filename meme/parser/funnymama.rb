module Meme

  module Parser
    
    class Funnymama < Meme::Parser::Base
    	
      def read_page page
        meme = []
        meme_on_page = page.search("article.post > .post-content")# > .post-img > a");
        meme_on_page.each do |d|
          ameme = Hash.new

          d.css(".post-img a").each do |node|
            pp node
            ameme[:url] = node['href']
            ameme[:src] = build_photo_url(node.children[1]['src'])
            ameme[:id]  = get_meme_id(node['href'])            
            ameme[:comment_url] = comment_url(get_meme_id(node['href']))
            ameme[:info] = Hash.new 
            ameme[:info][:share] = Hash.new
          end
              
          info_type = 0;
          d.css(".post-info .post-info-shares li > span").each do |node|
            pp node.children 

            case info_type
              when 0
                ameme[:info][:comment] = node.children.to_s
              when 1                  
                ameme[:info][:like] = node.children.to_s
              when 2                  
                ameme[:info][:share][:facebook] = node.children.to_s
              when 3                  
                ameme[:info][:share][:twitter] = node.children.to_s
            end

            info_type = info_type + 1    

          end
          meme.push(ameme) 
        end
        meme
      end

      def fetch(section, start_id=0, end_id=0, quantity=10)
        url = @url
        url = "#{@url}fun\/#{section}" unless 1 == section.to_i   
        puts url
        page = @agent.get url
        #puts page.inspect
        self.read_page(page)
      end

      def comment_url meme_id
        "https://www.facebook.com/plugins/comments.php?api_key=111569915535689&locale=en_US&sdk=joey&channel_url=https%3A%2F%2Fs-static.ak.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D18%23cb%3Df4ae20df94368a%26origin%3Dhttps%253A%252F%252F9gag.com%252Ff347388e2f6e8%26domain%3D9gag.com%26relation%3Dparent.parent&numposts=10&width=320&href=http%3A%2F%2F9gag.com%2Fgag%2F#{meme_id}"
      end

      private 
        def get_meme_id post_url
          post_url.sub!('/post/','').to_i
        end

        def set_resource 
          @url = 'http://funnymama.com/' #assume funny mama for now
        end

        def build_photo_url photo
          return photo.gsub("_460x.jpg", '_600x.jpg')
        end

    end 
    
  end 

end