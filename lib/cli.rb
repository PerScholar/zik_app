class Cli
  def run
    puts 'Welcome!'
    Scraper.new.init
    main_menu
  end

  def disp_main_menu
    puts ""
    puts <<-DOC.gsub /^\s*/, ''
        1. View full list
        2. Search
        3. About the list
        4. Credits
        5. Exit
    DOC
    puts 'Choose an option: '
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
    puts 'Choose an option: '
  end

  def disp_detail_menu
    puts ""
    puts <<-DOC.gsub /^\s*/, ''
        1. Song details
        2. Back to main menu
        3. Exit
    DOC
    puts 'Choose an option: '
  end

  def main_menu
    disp_main_menu
    input = gets.strip
    case input
    when '1'
      Song.songs.each { |s|
        puts "#{s.rank}: #{s.title}, By #{s.band}."
      }
      puts "\n"
      detail_menu
    when '2'
      search_menu
    when '3'
      Song.songs.each { |s|
        puts "#{s.rank}, #{s.title},  #{s.band}"
      }
    when '4'
      puts '4'
    when '5'
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
      hash.each { |k, v| puts "#{k}: #{v[0]}, By #{v[1]}." }
    end
    puts "\n"
    search_menu
    # File.open("log.txt", "a") { |f| f.write "#{Time.now} - Rankings of \"#{searched_artist.name}:\" \n #{searched_artist.albums}\n" }
  end

  def search_by_song
    puts ""
    puts "Let's find the rankings of your favorite song in our top-50 list: "
    print "Enter the song title: "
    input = gets.strip
    searched_song = input
    return_val = Song.find_by_song(searched_song)
    puts ""
    if return_val.instance_of? String
      puts return_val
    else
      return_val.each { |v|
        puts "Rank: #{v[0]}"
        puts "Band: #{v[1]}"
      }

    end
    puts "\n"
    search_menu
    # File.open("log.txt", "a") { |f| f.write "#{Time.now} - Rankings of \"#{searched_artist.name}:\" \n #{searched_artist.albums}\n" }
  end

  def disp_detail
    puts ""
    puts "Enter rank: (1-50)"
    input = gets.strip.to_i
    if (input.between?(1,50))
      #arr = @detail[input-1]
      #rows = []
      #rows[0] = ['','','','','']
      #rows[1] = ["No. #{input}",arr[7...arr.index("Producer")],arr[arr.index("Producer")...arr.index("Released")],arr[arr.index("Released")...arr.index(",")],arr[arr.index(",")...arr.index("weeks")]]
      #rows =[[1,2,3,4,5],[1,2,3,4,5],[1,2,3,4,5]]
      #rows[2] = ['','','','','']
      #table_one = Terminal::Table.new :headings => ['Rank:','Writer:', 'Producer:', 'Released:', 'Record Company:'], :rows => rows
      #puts table_one
      #table_two = Terminal::Table.new :headings => ["","",""], :rows => [["","",""],["",arr[arr.index("No.")...-1],""],[""]]
      #puts table_two
      #puts arr[arr.index("No.")...-1]
      #puts @detail[input-1]
      puts Song.songs[input-1].title
      puts ""
      puts "Written by: #{Song.songs[input-1].writers}."
      puts ""
      puts "Produced by: #{Song.songs[input-1].producers}."
      puts ""
      puts "Released on: #{Song.songs[input-1].release_date}."
      puts ""
      puts Song.songs[input-1].detail
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
      puts "#{Song.songs[input-1].title}, By #{Song.songs[input-1].band}."
      puts "\n"
      search_menu
    else
      search_menu
    end
  end
end




















end