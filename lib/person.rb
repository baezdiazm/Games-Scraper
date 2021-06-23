class Person
    attr_accessor :name
  
    @@all = []
    def initialize(name)
      @name = name
      @games = []
      @@all << self
    end
  
    def all
      @@all
    end
  
    def games
      @games
    end
  
    def add_game(game)
      @games << game
    end
  
    def remove_game(game)
      @games.delete(game)
    end
  
    def trade_game(person, game)
      person.add_game(game)
      self.remove_game(game)
    end
  
    def list_games
      index = 1
      @games.each do |game|
        puts "#{index}. #{game.name}."
        index += 1
      end
    end
  
    def view_game
      puts "SELECT the game you want to view:"
      puts
      index = 1
      self.games.each do |game|
        puts "(#{index}) #{game.name}"
        index += 1
      end
      selection = gets.chomp.to_i
      index = selection - 1
      puts
      if selection <= self.games.size && selection > 0
        puts self.games[index].name.upcase
        puts self.games[index].description.values.first
      end
    end
  
  end
  