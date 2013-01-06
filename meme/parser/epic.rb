  module Meme

  module Parser
    
    class Epic < Meme::Parser::Base
    	
      def read_page page
        meme = []
        meme_on_page = page.search("li.gag-link")# > .post-img > a");
        meme_on_page.each do |d|
          ameme = Hash.new

          d.css(".info h1 > a").each do |node|
            ameme[:title] = node.children.to_s
          end
          
          node = d.css(".img-wrap > a").first          
          pp node.children[0]
          if (node.children.length==1 && node.children[0]['class']=='loadpic')
            ameme[:url] = node['href']
            ameme[:id]  = get_meme_id(node['href'])  
            ameme[:src] = build_photo_url(node.children[0]['src'])                      
            ameme[:comment_url] = comment_url(ameme[:id])
            ameme[:info] = Hash.new 
            ameme[:info][:share] = Hash.new
          
            like_node = d.css(".actions-wrap > p > span.viewd");
          
          p "============"
          pp like_node.first.children[1]
          p "============"
          begin 
            ameme[:info][:like] = like_node.first.children[1].to_s
          rescue Exception => e
              ameme[:info][:like] = 0
          end

          fql_comment = "SELECT%20url,%20normalized_url,%20share_count,%20like_count,%20comment_count,%20total_count,%20commentsbox_count,%20comments_fbid,%20click_count%20FROM%20link_stat%20WHERE%20url=%27http://epic.vn/p/#{ameme[:id]}%27"
          
          #response = RestClient.get "https://graph.facebook.com/fql", {:params => {:q => fql_comment}}     
          
          #response = JSON.parse reponse.to_str
          #pp reponse
          #ameme[:info][:comment] = response[:data].first[:comment_count]
          #ameme[:info][:share][:facebook] = response[:data].first[:share_count]
          
            meme.push(ameme) 


          end
        end
        meme
      end

      def fetch(section, start_id=0, end_id=0, quantity=10)
        url = @url
        url = "#{@url}votejson.php?page=#{section}" unless 1 == section.to_i   
        puts url
        page = @agent.get url
        #puts page.inspect
        self.read_page(page)
      end

      def comment_url meme_id
        "https://www.facebook.com/plugins/comments.php?api_key=266042506822119&locale=vi_VN&sdk=joey&channel_url=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter.php%3Fversion%3D18%23cb%3Df3d969bd93e0516%26origin%3Dhttp%253A%252F%252Fepic.vn%252Ffc3da058f922f2%26domain%3Depic.vn%26relation%3Dparent.parent&numposts=10&width=700&href=http%3A%2F%2Fepic.vn%2Fp%2F#{meme_id}"
      end

      private 
        def get_meme_id post_url
          post_url.sub!('http://epic.vn/p/','').to_i
        end

        def set_resource 
          @url = 'http://epic.vn/' 
        end

        def build_photo_url photo_url
          photo_url
        end

    end 
    
  end 

end