module Meme

  module Parser
    
    class Lolhappen < Meme::Parser::Base
    	
      def read_page page
        meme = []
        meme_on_page = page.search(".content-wrap .post")
        meme_on_page.each do |d|
          ameme = Hash.new

          d.css(".post-title h2 > a").each do |node|
            ameme[:title] = node.children.to_s
            ameme[:url] = node['href']            
            ameme[:id] = get_meme_id(d["id"])
            ameme[:comment_url] = comment_url(ameme[:id])
          end
          
          ameme[:info] = Hash.new             
          ameme[:info][:share] = Hash.new
          d.css(".post-content > p > img").each do |node|
            ameme[:src] = build_photo_url(node['src'])            
          end
             
          d.css(".post-content > .pull-right > .lolcount").each do |node|
            ameme[:info][:like] = node.children.to_s            
          end

          d.css(".post-meta span.fb_comments_count").each do |node|
            ameme[:info][:comment] = node.children.to_s            
          end
              
          info_type = 0
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
        url = "#{@url}page\/#{section}" unless 1 == section.to_i   
        puts url
        page = @agent.get url
        #puts page.inspect
        self.read_page(page)
      end

      def comment_url meme_id
        "https://www.facebook.com/plugins/comments.php?api_key=109473309168726&locale=en_US&sdk=joey&channel_url=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D18%23cb%3Df73678848c858%26origin%3Dhttp%253A%252F%252Fwww.lolhappens.com%252Ff8156cc97406d4%26domain%3Dwww.lolhappens.com%26relation%3Dparent.parent&numposts=15&width=650&href=http%3A%2F%2Fwww.lolhappens.com%2F#{meme_id}%2Fwindows-keeping-its-legacy-alive%2F"
      end

      private 
        def get_meme_id meme_id
          meme_id.sub!('post-','').to_i
        end

        def set_resource 
          @url = 'http://www.lolhappens.com/'
        end

        def build_photo_url photo
          return photo
        end

    end 
    
  end 

end