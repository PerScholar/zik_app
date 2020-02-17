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
  
  def Song.find_by_song(searched_song)
    puts searched_song.downcase
    arr = []
    @@songs.each { |s|
      arr << [s.rank,s.title,s.band] if s.title.downcase.include?(searched_song.downcase)
    }
    return arr if arr != []
    return 'No such song in our list!'
  end
end