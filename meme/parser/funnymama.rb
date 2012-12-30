module Meme

  module Parser
    
    class Funnymama < Meme::Parser::Base
    	def read_page page
          meme = []
          meme_on_page = page.search("article.post > .post-content > .post-img > a");
          meme_on_page.each do |d|
            meme.push(
              {
                :url => d['href'], 
                :src => build_photo_url(d.children[1]['src']),
                :id  => get_meme_id(d['href']),                
                # :info => {
                #   :comment =>
                #   :like => 
                # }
              }
            ) 
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