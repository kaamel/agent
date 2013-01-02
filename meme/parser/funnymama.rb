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