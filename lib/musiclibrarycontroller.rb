require 'pry'
class MusicLibraryController

  def initialize(path = './db/mp3s')
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    input = ''

    while input != 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    # songs_sorted_by_name = Song.all.sort {|a, b| a.name <=> b.name}.uniq
    # songs_sorted_by_name.each.with_index do |song,index|
    #   # binding.pry
    #   puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    # end

    Song.all.sort {|a, b| a.name <=> b.name}.uniq.each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    Artist.all.sort {|a, b| a.name <=> b.name}.uniq.each.with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort {|a, b| a.name <=> b.name}.uniq.each.with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    artist = Artist.find_by_name(input)
    if artist
    artist.songs.sort {|a, b| a.name <=> b.name}.uniq.each_with_index {|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}

    # binding.pry
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if genre = Genre.find_by_name(input)
    genre.songs.sort {|a,b| a.name <=> b.name}.uniq.each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
  end
end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    if (1..Song.all.length).include?(input)
      song = Song.all.sort {|a,b| a.name <=> b.name}.uniq[input - 1]
      if song != nil
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end
  end
  #binding.pry

    # what does this method want me to do?
    # play the song from list_songs that matches the user's input
    # how do I match users input to list_songs
    # how do I match the number provided by the user to the number of the song in the list
    # array can store infinite amount of songs so users input isn't finite it also can be infinite which means we need to use a range
    # how do I use a range and compare it to something else to return a comparison value
  #   def play_song
  #   puts "Which song number would you like to play?"
  #   input = gets.strip.to_i
  #   users_input_matches_with_song_position = (1..Song.all.length).include?(input)
  # #   # if the number within Song.all matches users_input then puts
  #   if users_input_matches_with_song_position
  # #     # song = list_of_the_song[input]
  #   song = Song.all.sort {|a,b| a.name <=> b.name}.uniq[input - 1]
  #     # song.name
  #     # song.artist.name
  #     puts "Playing #{song.name} by #{song.artist.name}"
  #     # binding.pry
  #
  #     # puts "#{song.artist.name}"
  #
  # end
  #
  # end



end
