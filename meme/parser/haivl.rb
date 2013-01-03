module Meme

  module Parser 
    class Haivl < Meme::Parser::Base

      def read_page page
          meme = []
          meme_on_page = page.search(".photoList > .photoListItem")
          id = 0;
          meme_on_page.each do |d|
            #pp d
            ameme = {
                :url => d.children[3].children[1]['href'], 
                :src => build_photo_url(d.children[3].children[1].children[1]['src']),
                :id  => get_meme_id(d.children[3].children[1]['href']),      
                :comment_url => get_meme_id(d.children[3].children[1]['href']),           
                :info => {
                  :comment => 0,
                  :like => 0
                }          
            }
            info_type = 1;
            stat = d.css(".stats > span").each do |node|
              pp node
              case info_type
                when 1
                  ameme[:info][:like] = node.children.to_s
                when 2
                  ameme[:info][:comment] = node.children.to_s 
              end
              info_type = info_type+1
            end
            meme.push(ameme)
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


      def comment_url meme_id
        "https://www.facebook.com/plugins/comments.php?api_key=111569915535689&locale=en_US&sdk=joey&channel_url=https%3A%2F%2Fs-static.ak.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D18%23cb%3Df4ae20df94368a%26origin%3Dhttps%253A%252F%252F9gag.com%252Ff347388e2f6e8%26domain%3D9gag.com%26relation%3Dparent.parent&numposts=10&width=320&href=http%3A%2F%2F9gag.com%2Fgag%2F#{meme_id}"
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