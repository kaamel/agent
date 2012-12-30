module Meme

  module Parser 
    class Haivl < Meme::Parser::Base

      def read_page page
          meme = []
          meme_on_page = page.search(".photoList > .photoListItem")
          id = 0;
          meme_on_page.each do |d|
            #pp d
            meme.push(
              {
                :url => d.children[3].children[1]['href'], 
                :src => build_photo_url(d.children[3].children[1].children[1]['src']),
                :id  => get_meme_id(d.children[3].children[1]['href']),                
              }
            ) 
          end
          meme
      end

      def fetch(section, start_id=0, end_id=0, quantity=10)
        url = @url
        url = "#{@url}new/#{section}" unless 1 == section.to_i  
        
          puts "Start to fetch from: #{url}"
          begin
            page = @agent.get url
          rescue Exception => e
            puts e.inspect
            raise e
          end
          self.read_page(page)
      end

      private

      def get_meme_id(post_url)
        post_url.sub!('/photo/','').to_i
      end

      def set_resource 
        @url = 'http://www.haivl.com/' 
        puts "Set resource for haivl site"
      end

      def build_photo_url photo
        return photo.gsub("-400.jpg", '-650.jpg')
      end

    end  

  end
end