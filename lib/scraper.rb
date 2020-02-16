# frozen_string_literal: true

class Scraper
  attr_accessor :doc
  def init
    html = open('https://www.rollingstone.com/music/music-lists/500-greatest-songs-of-all-time-151127/?list_page=10#list-item-50')
    @doc = Nokogiri::HTML(html)
    scrape_list
  end

  def scrape_list
    list = {}
    @doc_list = @doc.search('h3.c-list__title')
    list_detail = @doc.search('div.c-list__lead.c-content')
    list_arr = []
    detail_arr = []

    50.times { |i|
      list_arr << @doc_list[i].text.chomp.strip
      detail_arr << list_detail[i+1].text.chomp.strip
      list[(i-50).abs] = list_arr[i].split(',')
  
      list.sort.to_h.each { |k,v|
        hash = {}
        hash["details"] = detail_arr[(k.to_i-50).abs]



        Song.instantiate_from_hash(hash)
    
    
    
    
    
      }
  
  
  
     }
   puts list_arr


  end
end
