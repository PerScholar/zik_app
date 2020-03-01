class Cli
  def run
    disp_logo
    puts 'Welcome!'
    Scraper.new.init
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
  end

  def disp_main_menu
    puts ""
    puts <<-DOC.gsub /^\s*/, ''
        Main Menu:
        1. View full list
        2. Search
        3. Credits
        4. Exit
    DOC
    print 'Choose an option: '
  end

  def disp_search_menu
    puts ""
    puts <<-DOC.gsub /^\s*/, ''
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
      search_menu
    when '3'
      puts "Info source: https://www.rollingstone.com/music/music-lists/500-greatest-songs-of-all-time-151127/?list_page=10#list-item-50"
    when '4'
      exit
    else
      puts 'Invalid entry!'
      print "\n"
    end
    main_menu
  end

  def search_menu
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
    else
      hash = searched_band.find_by_name
      hash.each { |k, v| puts "#{k}: #{v[0]}, by #{v[1]}." }
    end
    puts "\n"
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
    else
      return_val.each { |v|
        puts "#{v[0]}: #{v[1]}"
      }
    end
    puts "\n"
    search_menu
  end

  def disp_detail
    puts ""
    puts "Enter rank: (1-50)"
    input = gets.strip.to_i
    if (input.between?(1,50))
      puts Song.songs[input-1].title
      puts ""
      puts "Performed by: #{Song.songs[input-1].band}."
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
      disp_detail
    end
  end

  def search_by_rank
    puts ""
    puts "Enter rank: (1-50)"
    input = gets.strip.to_i
    if (input.between?(1,50))
      puts "No. #{input}: #{Song.songs[input-1].title}, by #{Song.songs[input-1].band}."
      puts "\n"
      search_menu
    else
      search_menu
    end
  end
end
