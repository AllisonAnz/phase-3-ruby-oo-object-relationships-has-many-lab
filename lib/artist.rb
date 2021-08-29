# Artist 
# #new: initialized with a name 
# #name has an attr_accessor for a name 
# #songs has many songs 
# #add_song: take in an argument of a song and associates that song with the artist by 
#            telling the song that it belongs to that artist 
# #add_song_by_name: takes an argument of a song name, creates a new song with it and associates the song and artist 
# .song_count: class method that returns the total number of songs associated to all existing artist 


class Artist
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def add_song(song)
    song.artist = self
  end

  def add_song_by_name(name)
    song = Song.new(name)
    song.artist = self
  end

  def songs
    Song.all.select {|song| song.artist == self}
  end

  def self.song_count
    Song.all.count
  end
end
