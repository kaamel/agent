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
                :src => build_photo_url(d.children[3].children[1].children[1]['src']),
                :id  => get_meme_id(d.children[3].children[1]['href']),      
                :comment_url => comment_url(get_meme_id(d.children[3].children[1]['href'])),           
                :info => {
                  :comment => 0,
                  :like => 0
                }          
            }
            ameme[:url] = build_post_url(ameme[:id])
                
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
            
            d.css(".info > h2 >a").each do |title|
              ameme[:title] = title.children.to_s
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
        "https://www.facebook.com/plugins/comments.php?api_key=378808135489760&locale=en_US&sdk=joey&channel_url=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D18%23cb%3Df6323f962faca8%26origin%3Dhttp%253A%252F%252Fwww.haivl.com%252Ffe9f40a6684b34%26domain%3Dwww.haivl.com%26relation%3Dparent.parent&numposts=10&width=655&href=http%3A%2F%2Fwww.haivl.com%2Fphoto%2F#{meme_id}"
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

        def build_post_url id
          "#{@url}/photo/#{id}"
        end


    end  

  end
end