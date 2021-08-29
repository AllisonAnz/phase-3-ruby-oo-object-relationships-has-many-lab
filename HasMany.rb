# Has Many Relationship 

# Describe the "has many" relationship between Ruby objects
# Build classes that produce objects with a "belongs-to" and "has-many" relationship
# Explain why we need to associate objects in this way

# Review on "Belongs-to" relationship 

# We have a Song class that produces individual song objects 
# Each song belongs to the artist who wrote it 
# Using attr_accessor in Song class for artist we can build a relationship 
class Song
  attr_accessor :artist, :name, :genre

  def initialize(name, genre)
    @name = name
    @genre = genre
  end
end 

class Artist
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end 

kiki = Song.new("In My Feelings", "hip-hop")
drake = Artist.new("Drake")
kiki.artist = drake
kiki.artist.name
  # => "Drake" 

  # We could just set the artist attribute equal to a sime string 
  # However if we instead use the artist= method to set the attribute equal to 
  # a real instance of the rtist class, we are associating our song to a robust object 
  # that has its own attributes and behaviors 
  #---------------------------------------------------------------------------------------

  # The "has-many" Relationship 
  # The inverse of "belongs-to" 
  # If a song belongs to an artist, then an artist should be able to have many songs 
  # We can represent an object's "having many" of something 
  # a collection of that thing 
  # Ruby offers a great way to store collections of data in list from: arrays 

  # We would like to call 
  # drake.songs 
  #=> list of arrays, of the songs that Drake has written

  # One way to implement this is to create an instance variable, an array that holds the songs
  # belonging to a given artist 
  # As songs are created that belong to that artist, they can be added to the array 

# Initialzing with an Empty Collection 
    # If we want each artist istance to have an instance variable #songs to hold their song instances 
    # create the variable when the artist is created 
    class Artist
        attr_accessor :name 
        def initialize(name)
            @name = name 
            @songs = []
        end 
    end 

    # Above we set an instance variable @songs, equal to an ampty array 
    # Recall we use instance variables to store attributes of a given instance of a class 

# Adding items to the collection 
    # The Artist class is responsible for adding the new song to the artist collection at the time the song is created 
    class Artist
        attr_accessor :name

        def initialize(name)
          @name = name
          @songs = []
        end

        # This method adds songs to an artist's collection 
        def add_song(song)
            @songs << song 
        end 
    end

    drake = Artist.new("Drake")
    drake.add_song("In My Feelings")
    drake.add_song("Hotline Bling") 

    # Now we need a method that will allow a given artist to show us all of the songs in their collection 

# Exponsing the Collection 
    # Write an instnce method #songs, that can be called on an individual artist to return the list of songs that the artist has 
    class Artist
            attr_accessor :name

            def initialize(name)
              @name = name
              @songs = []
            end

            # This method adds songs to an artist's collection 
            def add_song(song)
                @songs << song 
            end 

            # Instance method, that can be called on an individual artist and return a list of songs
            def songs 
                @songs 
            end
        end

        drake = Artist.new("Drake")
        drake.add_song("In My Feelings")
        drake.add_song("Hotline Bling") 
        drake.songs # => ["In My Feelings", "Hotline Bling"] 

# Relating Objects with "belongs to" and "has many
    # Lets ask drake to tell us the genres of the songs he has many of 
    # As of right now, it can't because the songs are simply a string 
    # You can't ask a song string what genre it is because it doesn't know 

    # To fix this 
    # Instead of calling the #add_song method with an argument of a string 
    # lets call the method with an argument of a real song object 
        # Song class has two instance variables, a name and a genre
        kiki = Song.new("In My Feelings", "hip-hop")
        hotline = Song.new("Hotline Bling", "pop")

        drake.add_song(kiki)
        drake.add_song(hotline)

        p drake.songs
          # =>[#<Song:0x007fa96a878348 @name="In My Feelings", @genre="hip-hop">, #<Song:0x007fa96a122580 @name="Hotline Bling", @genre="pop">] 

    # Now our aritst has many songs that are realy tangible Song isntances and not just Strings 

    # We can do several useful things with this collection of real song objects 
    # such as iterate over them and collecet their genres 
    # drake.songs.collect do |song|
    #     song.genre 
    # end 
    # => ["hip-hop", "pop"] 

# Object Reciprocity 
    # Now we can ask our given aritst for their songs, let's make sure that we can ask an individual song for its artist 
    # kiki.artist 
       #=> 
    
    # Although we do have an attr_access for artist in our Song class 
    # This particular song doesn't seem to know that it belongs to Drake 
    # This is because our #add_song method only accomplished associating the song object to the artist object

    # Our artist knows it has a collection of songs and knows how to add songs to that collection 
    # But, we didn't tell the song we added to the artist, that it belonged to the artist

    # The song instance will keep track of the artist it belongs to 

    # Fix that 
    # Tell a song that it belongs to an artist should happen when that song is added to the artists @song
     class Artist
            attr_accessor :name

            def initialize(name)
              @name = name
              @songs = []
            end

            # This method adds songs to an artist's collection 
            def add_song(song)
                @songs << song 
                # tells a song that it belongs to the artist on which we are calling thie method
                # we call the #artist= method on the song that is being passed in as an argument 
                # and set it equal to self (the artist)
                song.artist = self
            end  

            # Instance method, that can be called on an individual artist and return a list of songs
            def songs 
                @songs 
            end
        end

        # We can call #add_song
        drake.add_song(kiki) 
        p kiki.artist.name
        # => "Drake" 

        # Now an artist has many songs, but songs belong to an artist 

# Maintaing a Single Source of Trust 
# The add_song method works but there is a flaw in this set up 
def add_song(song)
  @songs << song
  song.artist = self
end 

# With this implementation, we're maintaining this relationship on Boeth the Song instance and the Artist instance 
# We've dont this so that an artist knows which songs it has, and a song knows the aritst it belongs to 

# However, keeping this information maintained on boeth sides of the relationship means there 
# are TWO SOURCES OF TRUTH 
#   the song's knowledge of who its artist is (established by using the aritst= method)
#   and the artist's knowledge of which song it has (this list of songs in the artists @song array)

# Say we don't consistently use the add_song method?
# What if, somehwere along the lines we did something like this 
lil_nas_x = Artist.new("Lil Nas X")
old_town_road = Song.new("Old Town Road","hip-hop")

old_town_road.artist = lil_nas_x

old_town_road.artist.name #=> "Lil Nas X"
lil_nas_x.songs #=> [] 

# Now, the Song instance old_town_read is associated with an aritst, 
# but lil_nas_x doesn't know about old_town_road 
# b/c the song was not added to lil_nas_x's @song array 
# We have two sources of truth about artists and their songs 
# One from the artists side and one from the song side 

# Song instance keeps track of the aritst it belongs to 

# A better way to approach this would be to figure out how to maintain our "has-many"/"belongs-to" relationship 
# on only ONE side of the realationship 

# We can do that by having the Song class keep a list of all of the songs by all artists
# And writing the #songs method in our Artist class to query that list, asking for the songs that belong 
# to a given artist 

# Make some updates to the Song and Artist class 
# Say in song we set up a class variable, @@all = [], and a getter method .all 
# This way, when a song is initalized, we can push the instance into the @@all array and then use Song.all to 
# retrieve all Song instance

class Song
  attr_accessor :artist, :name, :genre
  # Class variable
  @@all = []

  def initialize(name, genre)
    @name = name
    @genre = genre
    #calls save method
    save
  end
 
  #pushes instance of Song class @all
  def save
    @@all << self
  end
 #displayed @@all
  def self.all
    @@all
  end
end 

# Now that we can get all song's we should be able to do this 
lil_nas_x = Artist.new("Lil Nas X")
rick = Artist.new("Rick Astley")

old_town_road = Song.new("Old Town Road","hip-hop")
never_gonna_give_you_up = Song.new("Never Gonna Give You Up","pop")

old_town_road.artist = lil_nas_x
never_gonna_give_you_up.artist = rick

Song.all.first.name #=> "Old Town Road"
Song.all.first.genre #=> "hip-hop"
Song.all.first.artist #=> #<Artist:0x00007ff1d90dbf38 @name="Lil Nas X", @songs=[]>
Song.all.first.artist.name #=> "Lil Nas X"

Song.all.last.name #=> "Never Gonna Give You Up" (the last song name in the array)
Song.all.last.genre #=> "pop"
Song.all.last.artist #=> #<Artist:0x00007ff1d90dbf38 @name="Rick Astley", @songs=[]>
Song.all.last.artist.name #=> "Rick Astley" (the last artist name in the array)

# Now we've got a way to get all songs, so if we want to a list of all the songs 
# that belong to a particular artist we can just select the appropriate song 
Song.all.select {|song| song.artist == lil_nas_x}
#=> [#<Song:0x00007ff1da1d3228 @name="Old Town Road", @genre="hip-hop", @artist=#<Artist:0x00007ff1d90dbf38 @name="Lil Nas X", @songs=[]>>]

Song.all.select {|song| song.artist == rick}
#=> [#<Song:0x00007ff1da87bc38 @name="Never Gonna Give You Up", @genre="pop", @artist=#<Artist:0x00007ff1da20b150 @name="Rick Astley", @songs=[]>>]

# We used .select to iterate through Song.all and return the subset of songs associated with a particular artist 
# We can incorporate this into our Artist class, 
# replacing the implementation of the #songs method so that it 
# SELECTS instead of returning the @song instance variable 
# b/c #song is an instance method, we can use self to represent the Artist instance this method is called on 

 class Artist
    attr_accessor :name
    def initialize(name)
      @name = name
      # We can get ride of the @song instance variable, b/c we can get the necessary information by selecting 
      # from Song.all
      # @songs = []
    end

     # This method adds songs to an artist's collection 
     def add_song(song)
         # We not longer need the @song << song b/c we can get information by selecting Song.all
         #@songs << song 

         # tells a song that it belongs to the artist on which we are calling thie method
         # we call the #artist= method on the song that is being passed in as an argument 
         # and set it equal to self (the artist)
         song.artist = self
     end  

    # Instance method, that can be called on an individual artist and return a list of songs
        #def songs 
            #@songs 
        #end
    #---Above is replaced with------
    # use .select to iterate through Song.all and return the subset of songs associated with a particular artist 
    # this replaced the implementation of the #songs method (above) so that it selects instead of returning 
    # the @song instance variable
    # Since #songs is an instance method, we can use self to represent the Artist instance the method is called on
    def songs 
        Song.all.select {|song| song.artist == self}
    end
end

# Now since we can get the necessary information by selecting from Song.all 
# We no longer need the @songs instance variable in our Artist class 
# We can get rid of that and update #add_song accordingly 
class Artist
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def add_song(song)
    song.artist = self
  end

  def songs
    Song.all.select {|song| song.artist == self}
  end
end 

# With the above implementation, we're able to achieve a "has-many"/"Belongs-to" relationship 
# while maintaining a single source of truth 
# Not only that we were able to simplify the Artist class without loosing any functionality 

# With our new set up, the issue of mainting boeth sides of the relationship is solved 

# By telling the song instance which aritst is belongs to, we are able to access the list of songs that 
# belong to a given artist 

# THis works wheter we use the Songs artist= method or the Artists class add_song method 

# Calling the artist= method on a Song instance 
lil_nas_x = Artist.new("Lil Nas X")
old_town_road = Song.new("Old Town Road","hip-hop")

old_town_road.artist = lil_nas_x

old_town_road.artist.name #=> "Lil Nas X"
lil_nas_x.songs #=> [#<Song:0x00007fb46b0a1c08 @name="Old Town Road", @genre="hip-hop", @artist=#<Artist:0x00007fb46b0e3748 @name="Lil Nas X">>] 

# Calling the add_song method on an Artist instance 
rick = Artist.new("Rick Astley")
never_gonna_give_you_up = Song.new("Never Gonna Give You Up","pop")
rick.add_song(never_gonna_give_you_up)

rick.songs #=> [#<Song:0x00007fb46b0b97b8 @name="Never Gonna Give You Up", @genre="pop", @artist=#<Artist:0x00007fb46a903000 @name="Rick Astley">>]
never_gonna_give_you_up.artist #=> #<Artist:0x00007fb46a903000 @name="Rick Astley"> 

#----------------------------------------------------------------------------------------------------------

# Extending the Association and Cleaning up our Code 
# The best thing about our code is that it accommodates future changes 
# We've build a solid associations between our Artist and Song class via our has many/belongs to code 
# We can make our code better by doing the following 

# The #add_song_by_name Method 
# Right now, we have to first create a song and then add it to a given artist's collection of songs 
# We can combine these two steps
# In the real-world environment of an artist and their songs, the current need to create a song 
# and then add it to an artist doesn't really make sence 
# A song doesn't exist before an artist creates it 

# Build a method #add_song_by_name 
# that takes in an argument of a name and genre and boeth creates the new song and adds that song to the 
# artists collection 
class Artist
  #...
  # We tell the song that it belongs to the artist, just as we do in our #add_song method 
  # We also create a new song instance using the name and genre from the argument
  # Now we don't have to create a new song on a separate line every time we want to add one to an artist
  def add_song_by_name(name, genre)
    song = Song.new(name, genre)
    song.artist = self
  end 
end


# The #artist_name Method 
# Currently, to access the name of a given song's artist, we have to chain our method like this 
kiki.artist.name
  # => "Drake" 

# We can imagine knowing the name of an artist that a particular song belongs to would be helpful and probably used 
# in multiple situations 
# It would be nice to have one simple and descriptive method that could return the name of a given 
# songs artist 
class Song 
    #...
    # method to return the name of a given songs artist 
    # self inside the #artist_name method refers to the instance of Song on which the method is being called on 
    # then we call #artist on that song instance 
    # this returns the Artist instance associated with the song
    def artist_name 
        self.artist.name 
    end 
end 

# Now we can call 
kiki.artist_name
  # => "Drake"


