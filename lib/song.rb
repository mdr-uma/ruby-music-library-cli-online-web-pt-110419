require 'pry'

class Song

  # include Concerns::InstanceMethods
  # extend Concerns::ClassMethods
  extend Concerns::Findable

  attr_accessor :name, :artist, :genre

   @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
    save
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name, artist = nil, genre = nil)
    new_song = Song.new(name, artist, genre)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
    # if !(genre.songs.include?(self))
    # end
  end

  # def self.find_by_name(name)
  #   self.all.find {|obj| obj.name == name}
  # end
  #
  # def self.find_or_create_by_name(name)
  #   find_by_name(name) || create(name)
  # end
  #   if self.find_by_name(name)
  #     self.find_by_name(name)
  # binding.pry
  #   else
  #     self.create(name)
  #   end
  # end

  def self.new_from_filename(filename)
    file = filename.split(" - ")
    artist, name, genre = file[0], file[1], file[2].gsub(".mp3", "")
    genre = Genre.find_or_create_by_name(genre)
    artist = Artist.find_or_create_by_name(artist)
    new(name,artist,genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |s| s.save}
    # binding.pry
  end

end
