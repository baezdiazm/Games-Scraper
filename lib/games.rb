class Games
    attr_accessor :name, :description
    @@all = []
  
    def initialize(game, desc)
      #Will take in a HASH of games scrapped from indiegames
        @name = game
        @description = desc
        @@all << self
    end
  
    def name
      @name
    end
  
    def description
      @description
    end
  
    def delete_game(game)
      self.all.delete(game)
    end
  
    def self.all
      @@all
    end
  
  
    def self.list_desc
      index = 1
      all.each do |game|
        puts "#{index}. #{game.name}."
        puts "  #{game.description.values.first}"
        puts
        puts
        index += 1
      end
    end
  
    def self.list_games
      index = 1
      all.each do |game|
        puts "#{index}. #{game.name}."
        index += 1
      end
    end
  
    def self.make_games(scraper)
      scraper.all_games.each do |game, desc|
        Games.new(game, desc)
      end
    end
  
  
    def self.prompt
      puts
      puts
      puts "SELECT the game you want to view:"
      puts
      index = 1
      Games.all.each do |game|
        puts "(#{index}) #{game.name}"
        index += 1
      end
  
    end
  
    def self.view_game
      puts "SELECT the game you want to view:"
      puts
      index = 1
      Games.all.each do |game|
        puts "(#{index}) #{game.name}"
        index += 1
      end
      selection = gets.chomp.to_i
      index = selection - 1
      puts
      if selection <= Games.all.size && selection > 0
        puts Games.all[index].name.upcase
        puts Games.all[index].description.values.first
      end
    end
  
  end
  