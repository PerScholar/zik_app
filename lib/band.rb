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