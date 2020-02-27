require 'nokogiri'
require 'open-uri'

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
      k = idx == 41 ? 2 : 1
      hash["details"] = data[k].text.strip
      idx_end = data.text.split(":")[1].include?("Producers") ? -9 : -8
      hash["writers"] = data.text.split(":")[1][0...idx_end].strip
      hash["producers"] = data.text.split(":")[2][0...-8].strip
      hash["release_date"] = data.text.split(":")[3].split(',')[0].strip
      Song.instantiate_from_hash(hash)
    }
  end
end


class Cli
  def run
    system('cls')
    disp_logo
    Scraper.new.init
    puts 'Welcome!'
    sleep 1
    main_menu
  end

  def disp_logo
    puts "_¶¶¶¶_________________________¶¶
__¶¶¶¶¶_______________________¶¶
__¶¶__¶¶_____________________¶¶¶¶
___¶¶__¶¶____________________¶¶¶¶¶
____¶¶_¶¶¶___________________¶¶__¶¶
____¶¶_¶¶¶___________________¶¶__¶¶
_____¶¶¶¶¶___________________¶¶_¶¶¶
_____¶¶¶¶______________¶¶¶¶ ¶¶__¶¶
____¶¶¶¶_____________¶¶¶¶¶¶¶¶¶_¶¶
___¶¶¶_¶¶__¶¶¶_______¶¶¶¶¶¶¶¶
__¶¶¶___¶¶¶¶¶¶¶¶¶_____¶¶¶¶¶¶
_¶¶¶¶__¶¶¶¶___¶¶¶¶_______________________¶¶
_¶¶¶__¶¶¶¶_¶¶¶__¶¶¶__________________¶¶¶¶¶¶
¶¶¶¶__¶¶¶¶¶¶¶¶¶__¶¶¶______________¶¶¶¶¶¶¶¶¶
_¶¶¶__¶¶¶_¶¶__¶__¶¶¶___________¶¶¶¶¶¶¶___¶¶
_¶¶¶¶__¶¶¶¶¶¶¶¶__¶¶________¶¶¶¶¶¶¶¶______¶¶
__¶¶¶¶____¶¶¶__¶¶¶______¶¶¶¶¶¶¶¶¶¶_______¶¶
___¶¶¶¶¶¶___¶¶¶¶¶______¶¶¶¶¶¶¶___¶¶_______¶¶
_____¶¶¶¶¶¶¶¶¶¶________¶¶¶¶¶_____¶¶___¶¶¶¶¶¶
________¶¶¶_¶¶¶________¶¶________¶¶__¶¶¶¶¶¶¶
_______¶¶¶¶¶_¶¶________¶¶_____¶¶¶¶___¶¶¶¶¶
_______¶¶¶___¶¶_________¶¶___¶¶¶¶¶¶
_________¶¶¶¶¶__________¶¶___¶¶¶¶¶¶
_________________________¶¶__¶¶¶¶
_____________________¶¶¶¶¶¶
____________________¶¶¶¶¶¶¶
____________________¶¶¶¶¶¶
"
=begin
  pastel = Pastel.new
  font = TTY::Font.new(:doom)
  print pastel.yellow(font.write("ZIK APP"))
  sleep 2
=end

puts "\n=========================================="
"<<< Designed & developed by AtlasGeek7 >>>".split('').each { |c|
  print "#{c}"
  sleep 0.1
}
puts "\n==========================================\n"
sleep 1
system('cls')
  end

  def disp_main_menu
    system('cls')
    #puts ""
    puts <<-DOC.gsub /^\s*/, ''
        #=========================#
        #       Main Menu         #
        #=========================#
        1. View full list
        2. Search
        3. Credits
        4. Exit
    DOC
    print 'Choose an option: '
  end

  def disp_search_menu
    puts <<-DOC.gsub /^\s*/, ''
        #=========================#
        #       Search Menu       #
        #=========================#
        1. Search by band
        2. Search by song
        3. Search by rank
        4. Back to main menu
        5. Exit
    DOC
    print 'Choose an option: '
  end

  def disp_detail_menu
    puts ""
    puts <<-DOC.gsub /^\s*/, ''
        1. Song details
        2. Back to main menu
        3. Exit
    DOC
    print 'Choose an option: '
  end

  def main_menu
    disp_main_menu
    input = gets.strip
    case input
    when '1'
      Song.songs.each { |s| puts "#{s.rank}: #{s.title},  #{s.band}" }
      puts "\n"
      detail_menu
    when '2'
      sleep 1
      system('cls')
      search_menu
    when '3'
      disp_credits
    when '4'
      exit
    else
      puts 'Invalid entry!'
      print "\n"
    end
    main_menu
  end

  def search_menu
    sleep 1
    system('cls')
    disp_search_menu
    input = gets.strip
    case input
    when '1'
      search_by_band
    when '2'
      search_by_song
    when '3'
      search_by_rank
    when '4'
      main_menu
    when '5'
      exit
    else
      puts 'Invalid entry!'
      print "\n"
    end
    search_menu
  end

  def detail_menu
    disp_detail_menu
    input = gets.strip
    case input
    when '1'
      disp_detail
    when '2'
      main_menu
    when '3'
      exit
    else
      puts 'Invalid entry!'
      print "\n"
    end
    detail_menu
  end

  def search_by_band
    puts ""
    puts "Let's find the rankings of your favorite artist/band in our top-50 list: "
    print "Enter the artist/band's name: "
    input = gets.strip
    searched_band = Band.new(input)
    return_val = searched_band.find_by_name
    puts ""
    if return_val.instance_of? String
      puts return_val
      sleep 3
      system('cls')
    else
      hash = searched_band.find_by_name
      hash.each { |k, v| puts "#{k}: #{v[0]}, by #{v[1]}." }
      sleep 10
      system('cls')
    end
    search_menu
  end

  def search_by_song
    puts ""
    puts "Let's find the ranking of your favorite song in our top-50 list: "
    print "Enter the song title: "
    input = gets.strip
    searched_song = input
    return_val = Song.find_by_song(searched_song)
    puts ""
    if return_val.instance_of? String
      puts return_val
      sleep 3
      system('cls')
    else
      return_val.each { |v|
        puts "#{v[0]}: #{v[1]}"
      }
      sleep 10
      system('cls')
    end
    search_menu
  end

  def disp_detail
    system('cls')
    sleep 1
    #puts ""
    puts "#=========================#"
    puts "#       Song Info         #"
    puts "#=========================#"
    puts ""
    puts "Enter rank: (1-50)"
    input = gets.strip.to_i
    if (input.between?(1,50))
      puts Song.songs[input-1].title
      puts ""
      puts "Written by: #{Song.songs[input-1].writers}."
      puts ""
      puts "Produced by: #{Song.songs[input-1].producers}."
      puts ""
      puts "Released on: #{Song.songs[input-1].release_date}."
      puts ""
      puts Song.songs[input-1].details
      puts ""
      detail_menu
    else
      puts "Invalid entry!"
      sleep 1
      disp_detail
    end
  end

  def search_by_rank
    puts ""
    puts "Enter rank: (1-50)"
    input = gets.strip.to_i
    if (input.between?(1,50))
      puts "No. #{input}: #{Song.songs[input-1].title}, by #{Song.songs[input-1].band}."
      sleep 10
      system('cls')
      search_menu
    else
      puts "Invalid entry!"
      sleep 1
      search_menu
    end
  end

  def disp_credits
    puts "#=========================#"
    puts "#         Credits         #"
    puts "#=========================#"
    puts ""
    puts "Info source: https://www.rollingstone.com/music/music-lists/500-greatest-songs-of-all-time-151127/?list_page=10#list-item-50"
  end
end

class Band
  @@bands = []
  attr_accessor :name

  def initialize(name)
    @name = name
    @@bands << self
  end

  def songs
    hash = {}
    Song.songs.each { |s| hash[s.rank] = [s.title, s.band] if s.band.upcase.split(' ').include?(name.upcase) }
    hash
  end

  def find_by_name
    bool = songs != {}
    return songs if bool
    return 'No such name in our list!'
  end

end

class Song
  attr_accessor :rank, :title, :band,  :writers, :producers, :release_date, :details

  @@songs = []
  def self.instantiate_from_hash(hash)
    s = Song.new
        hash.each { |k,v| s.instance_variable_set("@#{k}",v) }
    s.save
  end

  def self.songs
    @@songs
  end

  def save
    @@songs << self
    self
  end

  def self.find_by_song(searched_song)
    puts searched_song.downcase
    arr = []
    @@songs.each { |s|
      arr << [s.rank,s.title,s.band] if s.title.downcase.include?(searched_song.downcase)
    }
    return arr if arr != []
    return 'No such song in our list!'
  end
end



Cli.new.run
