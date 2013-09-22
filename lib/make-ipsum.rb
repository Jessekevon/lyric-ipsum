require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'lyricfy'

module Ipsum

  class Song
    def initialize(artist, song)
      fetcher = Lyricfy::Fetcher.new
      @new_song = fetcher.search(artist, song)
      if @new_song == nil
        @new_song = fetcher.search("Rick Astley", "Never Gonna Give You Up")
        @no_song = true
      end
    end

    # def lines
    #   self["lines"]
    # end

    def lyrics
      @new_song.lines.sample(rand(10..15)).join(". ")
    end
  end

  # class
  # end
end

# fetcher = Lyricfy::Fetcher.new
# song = fetcher.search 'Artist', 'Song'
# puts song.body # prints lyrics separated by '\n'
