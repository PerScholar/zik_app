# frozen_string_literal: true

class Scraper
  attr_accessor :doc
  def init
    html = open('https://www.rollingstone.com/music/music-lists/500-greatest-songs-of-all-time-151127/?list_page=10#list-item-50')
    @doc = Nokogiri::HTML(html)
    scrape_list
  end

  def scrape_list
    list_info = @doc.css('h3.c-list__title')
    list_details = @doc.css("div.c-list__lead.c-content")
    50.times { |i|
      hash = {}
      idx = (i - 49).abs
      data =  list_details[idx+1].css('p')
      hash["rank"] = i + 1
      hash["title"] = list_info[idx].text.strip.split(',')[1..-1].join(' ')
      hash["band"] = list_info[idx].text.strip.split(',')[0]
      hash["details"] = data[1].text.strip
      hash["writers"] = data.text.split(": ")[1][0...-9].strip
      hash["producers"] = data.text.split(": ")[2][0..-10].strip
      hash["release_date"] = data.text.split(": ")[3].split(',')[0].strip
      Song.instantiate_from_hash(hash)
    }
  end
end
