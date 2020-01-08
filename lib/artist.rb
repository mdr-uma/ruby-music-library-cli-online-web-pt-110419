class Artist

  # include Concerns::InstanceMethods
	# extend Concerns::ClassMethods
	extend Concerns::Findable

  attr_accessor :name, :songs

   @@all = []

  def initialize(name)
    @name = name
    @songs = []
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

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  # def songs
  #   @songs
  # end

  def add_song(song)
  #   if song.artist == self
  #     song = nil
  #  else
  #   @songs << song.artist = self
  # end
  # @songs << song
  song.artist = self unless song.artist
  songs << song unless songs.include?(song)
  end

  def genres
    songs.collect {|song| song.genre}.uniq
  end
end
