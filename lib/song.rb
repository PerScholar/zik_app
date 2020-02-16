class Song
attr_accessor :rank, :title, : band, :details, :writers, :producers, :release_date
@@songs = []

def instantiate_from_hash(hash)
  s = Song.new
  hash.each { |k,v|
  s.send("#{k=}",v)
}
s.save
end

def save
  @@songs << self
  self
end

def Song.songs
  @@songs
end












end