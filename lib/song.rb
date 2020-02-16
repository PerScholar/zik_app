class Song
  attr_accessor :details#,:rank, :title, :band,  :writers, :producers, :release_date

  @@songs = []
  def self.instantiate_from_hash(hash)
    s = Song.new
    hash.each do |key, value|
      #puts "#{key}="
      #puts value
      s.send("#{key}=", value)
    end
    s.save
    #puts s
    #return s
  end

  def self.songs
    @@songs
  end

  def save
    @@songs << self
    self
  end











end