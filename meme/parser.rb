class MemeParser 

  def initialize source
    @source = source
    @url = 'http://funnymama.com/' #assume funny mama for now  
    @agent = Mechanize.new    
  end

  def read_page page
      meme = []
      meme_on_page = page.search("article.post > .post-content > .post-img > a");
      id = 0;
      meme_on_page.each do |d|
        meme.push({:url => d['href'], :src => d.children[1]['src']}) 
      end
      meme
  end

  def fetch section
    url = @url;
    url = "#{@url}fun\/#{section}" unless 1 == section.to_i   
    puts url
    page = @agent.get url
    puts page.inspect
    self.read_page(page)
  end

end


