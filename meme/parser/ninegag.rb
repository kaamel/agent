module Meme

  module Parser 
    class Ninegag < Meme::Parser::Base

    	def read_page page
          meme = []
          meme_on_page = page.search("#entry-list > #entry-list-ul > .entry-item");
          id = 0;
          meme_on_page.each do |d|
            meme.push(
              {
                :url => d['data-url'], 
                :src => build_photo_url(d['gagid'], 700, :b), 
                # 9gag follows a pattern for its pictur. d.children[1]['src'],
                #http://d24w6bsrhbeh9d.cloudfront.net/photo/6087941_460s.jpg
                # the pattern may change in future so it's better to build this dynamically
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
        url = "#{@url}fun#{section}" unless 1 == section.to_i  
        if (1==section.to_i)  
          puts "Start to fetch from: #{url}"
          begin
            page = @agent.get url
          rescue Exception => e
            puts e.inspect
            raise e
          end
          self.read_page(page)
        else
          url = "#{@url}new/json?list=hot&id=#{end_id}"
          puts "We start to get meme from this URL  #{url}"
          open(url) do |f|
            page = f.read
          end
          response = JSON.parse(page)
          meme =Array.new
          response['ids'].each do |id|
            meme.push({
              :url => build_post_url(id),
              :src => build_photo_url(id, 700, :b),
            })
          end        
          meme
        end        
      end

      private

      def set_resource 
        @url = 'https://9gag.com/' 
        puts "Set resource for 9gag site"
      end

      def build_photo_url(id, size, scale)
        "http://d24w6bsrhbeh9d.cloudfront.net/photo/#{id}_#{size}#{scale}.jpg"
      end

      def build_post_url id
        "http://9gag.com/gag/#{id}"
      end

    end
      
  end
end