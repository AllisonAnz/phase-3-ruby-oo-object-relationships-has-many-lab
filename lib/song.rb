#Song
  #new
  #  is initialized with an argument of a name 
  #  pushes new instances into a class variable called @@all upon initialization 
  # @@all
  #   is a class variable set to an array 
  # .all
  #   is a class method that returns an array of all song instances that have been created 
  #name: has a name 
  #artist: belongs to an artist 
  #artist_name: knows the name of its artist (returns nil if the song does not have an artist) 
require_relative "../lib/artist.rb"

  class Song 
    @@all = []
    attr_accessor :name, :artist

    def initialize(song_name)
        @name = song_name
        save
    end

    def save 
        @@all << self
    end

    def self.all 
        @@all 
    end

    def artist_name 
        artist.name if artist 
    end
    
  end

