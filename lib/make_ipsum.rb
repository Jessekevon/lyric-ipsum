require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'lyricfy'

module Ipsum
  attr_reader :no_song


  class Song

    # Instead of an extra database call, here is an array
    # with the lyrics to "Never Gonna Give You Up"
    RICKROLL_LINES = ["We're no strangers to love",
      "You know the rules and so do I",
      "A full commitment's what I'm thinking of",
      "You wouldn't get this from any other guy",
      "I just wanna tell you how I'm feeling",
      "Gotta make you understand",
      "Never gonna give you up",
      "Never gonna let you down",
      "Never gonna run around and desert you",
      "Never gonna make you cry",
      "Never gonna say goodbye",
      "Never gonna tell a lie and hurt you"]

    # Instead of connecting another API and making an extraneous database 
    # call, here is an array full of Latin nonsense.  
    LATIN = ["Consectetur adipiscing elit",
      "Aliquam volutpat urna turpis",
      "Fringilla elementum mauris venenatis ac",
      "Sed ac massa fringilla",
      "Porttitor augue eget",
      "Pulvinar augue",
      "Mauris felis ligula",
      "Adipiscing in tellus vel",
      "Condimentum tempus lacus",
      "Nullam id est nec mauris",
      "Sollicitudin molestie eu a tortor",
      "Sed egestas pretium nibh",
      "At vulputate lectus consequat in",
      "Integer adipiscing",
      "Lectus ut tincidunt accumsan",
      "Lorem odio ultrices elit",
      "Condimentum sollicitudin",
      "Odio orci eu eros",
      "In iaculis lorem eu mollis accumsan",
      "Nullam at molestie dui",
      "Donec commodo metus sed turpis",
      "Convallis pellentesque",
      "Aliquam ac ullamcorper libero",
      "Ut gravida leo at tellus mollis aliquet",
      "In vitae purus sagittis lectus",
      "Convallis fringilla ac id dolor",
      "Nulla facilisi",
      "In aliquet accumsan nunc",
      "At vulputate lectus pharetra luctus",
      "Sed faucibus molestie magna",
      "Et blandit turpis sagittis ut",
      "Quisque dictum bibendum orci",
      "At sodales diam suscipit vel",
      "Interdum et malesuada fames",
      "Ac ante ipsum primis in faucibus",
      "Sed justo nisi",
      "Lacinia nec porttitor nec",
      "Tincidunt sed nisi",
      "Duis nec tincidunt urna",
      "Integer pharetra odio vitae nibh viverra",
      "Sit amet malesuada lectus tempus",
      "Vestibulum felis lacus",
      "Ullamcorper ut molestie vitae",
      "Feugiat a libero",
      "Duis rutrum erat vel faucibus porttitor",
      "Fusce at nulla vel lacus pulvinar commodo",
      "Mauris at faucibus metus",
      "Curabitur fringilla diam a tortor elementum",
      "Ut ornare magna tincidunt",
      "Praesent vulputate lorem",
      "Sed mauris volutpat dignissim",
      "Phasellus ut nulla non diam",
      "Ornare aliquet gravida sed erat",
      "Mauris tempus sagittis metus",
      "Porttitor viverra odio tristique ac",
      "Fusce pulvinar elit orci",
      "Ut tincidunt leo pulvinar eget",
      "Fusce condimentum neque et",
      "Odio condimentum aliquam",
      "Aenean volutpat ipsum eu",
      "Massa laoreet convallis",
      "Nam lacinia erat magna",
      "Vitae porta augue sodales eu",
      "Aliquam sit amet bibendum dolor",
      "Nunc dignissim neque vel",
      "Magna posuere scelerisque",
      "Morbi condimentum risus et tempor vehicula",
      "Nunc pretium ligula et justo ullamcorper",
      "Id hendrerit urna ultrices",
      "Quisque lobortis arcu nec porta ultricies",
      "Vivamus ut tortor ac",
      "Tellus imperdiet malesuada"]

    attr_reader :title, :author, :lines, :no_song
    
    # Creates a new Fetcher object
    #
    # Fetcher will search the MetroLyrics and Lyric Wiki databases
    # 
    # return either RICKROLL_LINES or .lines (as defined by the 
    # Lyricfy gem) of the requested song.
    def initialize(artist, song)
      fetcher = Lyricfy::Fetcher.new

      if song = fetcher.search(artist, song)
        @lines = song.lines
      else
        @lines = RICKROLL_LINES
        @no_song = true
      end
    end

    def no_song?
      @no_song
    end

    # Randomizes the song by line.
    #
    # A random number of lines between 10 and 15 are taken out of
    # the song and put into an array. If Latin is passed in then 
    # between 6 and 12 lines of Latin are also randomly passed in.
    # The array is joined together by periods at the end.
    #
    # Returns a string of mixed lyrics and optional Latin.
    def random_lines(latin)
      number_of_lines = rand(10..15)
      song_lines = @lines.sample(number_of_lines)

      if latin
        rand(6..12).times do
          latin_line = LATIN.sample
          song_lines.insert(rand(number_of_lines), latin_line)
          number_of_lines += 1
        end
      end

      song_lines.join(". ")
    end
  end
end
