module Meme

  module Parser 
    class Ninegag < Meme::Parser::Base

    	def read_page page
          meme = []
          meme_on_page = page.search("#entry-list > #entry-list-ul > .entry-item");
          meme_on_page.each do |d|
            ameme = Hash.new

            ameme[:url] = d['data-url']
            ameme[:id]  = d['gagid'].to_i
            ameme[:comment_url] = comment_url(d['gagid'].to_i)
            ameme[:info] = Hash.new 
            ameme[:info][:share] = Hash.new
            
            d.css(".content > .img-wrap > a> img").each do |node|
              ameme[:src] = build_photo_url(node['src'], 700, :b)
            end

            info_type = 0
            d.css(".info .actions-wrap p span").each do |node|
              pp node.children

              case info_type
                when 0
                  ameme[:info][:comment] = node.children.to_s
                when 1                  
                  ameme[:info][:like] = node.children.to_s                
              end
              info_type = info_type + 1
            end

            d.css(".info .actions-wrap .sharing-box .b2-widget-count > div.b2-widget-val").each do |node|
              ameme[:info][:share][:twitter] = node.children.to_s                    
            end

            d.css(".info .actions-wrap .sharing-box .facebook_share_count_inner").each do |node|
              ameme[:info][:share][:facebook] = node.children.to_s                    
            end

            d.css(".info > .sticky-items > h1 >a").each do |title|
              ameme[:title] = title.children.to_s
            end

            meme.push(ameme) 
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
          # response['ids'].each do |id|
          #   meme.push({
          #     :url => build_post_url(id),
          #     :src => build_photo_url(id, 700, :b),
          #     :id => id.to_i
          #   })

          # end

          response['items'].each do |k, v|
            dom = Nokogiri::HTML(v)
            node = dom.css('li.entry-item').first
            id = node['gagid']
            pp node
            puts "====================================="
            ameme = {
              :url => build_post_url(id),
              :id => id.to_i,
              :comment_url => comment_url(id),
              :info => Hash.new 
            }

            node.css(".content > .img-wrap > a> img").each do |img|
              ameme[:src] = build_photo_url(img['src'], 700, :b)
            end

            info_type = 0
            node.css(".info .actions-wrap p span").each do |stat_node|
              case info_type
                when 0
                  ameme[:info][:comment] = stat_node.children.to_s
                when 1                  
                  ameme[:info][:like] = stat_node.children.to_s                
              end
              info_type = info_type + 1
            end

            ameme[:info][:share] = Hash.new
            node.css(".info .actions-wrap .sharing-box .b2-widget-count > div.b2-widget-val").each do |stat_node|
              ameme[:info][:share][:twitter] = stat_node.children.to_s                    
            end

            node.css(".info .actions-wrap .sharing-box .facebook_share_count_inner").each do |stat_node|
              ameme[:info][:share][:facebook] = stat_node.children.to_s                    
            end

            node.css(".info > .sticky-items > h1 >a").each do |title|
              ameme[:title] = title.children.to_s
            end

            meme.push(ameme)            
          end        
          meme
        end        
      end

      def comment_url meme_id
        "https://www.facebook.com/plugins/comments.php?api_key=111569915535689&locale=en_US&sdk=joey&channel_url=https%3A%2F%2Fs-static.ak.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D18%23cb%3Df4ae20df94368a%26origin%3Dhttps%253A%252F%252F9gag.com%252Ff347388e2f6e8%26domain%3D9gag.com%26relation%3Dparent.parent&numposts=10&width=320&href=http%3A%2F%2F9gag.com%2Fgag%2F#{meme_id}"
      end

      private

      def set_resource 
        @url = 'https://9gag.com/' 
        puts "Set resource for 9gag site"
      end

      def build_photo_url(photo_url, size, scale)
        photo_url.gsub('460s', "#{size}#{scale}")
      end

      def build_post_url id
        "http://9gag.com/gag/#{id}"
      end

    end
      
  end
end