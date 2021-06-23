# frozen_string_literal: true

require_relative "game_scraper/version"
require_relative 'scraper.rb'
require_relative 'person.rb'
require_relative 'games.rb'
require_relative 'scraper.rb'
#require 'pry'
  
  def clear
    puts "\e[H\e[2J"
  end
  
  def returning
    puts "Returning to main menu"
    main_screen
  end
  
  def trade(want, give)
    @player.add_game(@npc.games[want-1])
    @npc.add_game(@player.games[give-1])
    @player.remove_game(@player.games[give-1])
    @npc.remove_game(@npc.games[want-1])
  end
  
  def greeting
    @player = nil
    clear
    puts "Welcome to this... Whatever this is."
    puts
    puts "Looks like this is your first time here."
    puts "What is your name?"
    name = gets.chomp
    @player = Person.new(name)
    clear
    puts "Welcome, #{@player.name}!"
    puts "What would you like to do?"
    puts
    main_screen
    first_time = false
  end
  
  def main_screen
    puts "-----------------------------------MAIN MENU-----------------------------------"
    puts "1) Shop Games"
    puts "2) Trade Game"
    puts "3) Toss Game"
    puts "4) Give game"
    puts "5) Take game"
    puts "6) Change your name"
    puts "7) View your games"
    puts "8) View NPC's games"
    puts "9) Exit"
    puts
  
    selection = gets.chomp.to_i
    if selection > 0 && selection < 10
      case selection
        when 1 #######################################      SHOP GAMES
          clear
          puts "-----------------------------------SHOPPING GAMES-----------------------------------"
          puts
          if Games.all.size > 0
            puts "Available games:"
            Games.list_games
            puts "#{Games.all.size+1}. Exit"
            puts
            puts "Select the game you'd like to 'Buy':"
            choice = gets.chomp.to_i
            if choice > 0 && choice <= Games.all.size
              @player.add_game(Games.all[choice-1])
              Games.all.delete(Games.all[choice-1])
              clear
              puts "#{@player.games.last.name} has been added to your inventory"
            elsif choice == Games.all.size+1 ###(The 'EXIT' button)
              clear
              returning
            else
              clear
              puts "INVALID SELECTION"
              returning
            end
          else
            clear
            puts "There are no games available at the moment..."
          end
          main_screen
        when 2  #######################################     TRADE GAMES
          clear
          puts "-----------------------------------TRADING-----------------------------------"
          puts
          if @player.games.size > 0
            puts "Select the game you want from #{@npc.name}"
            puts
            @npc.list_games
            wanted = gets.chomp.to_i
            clear
            puts "-----------------------------------TRADING-----------------------------------"
            puts
            puts "You want: #{@npc.games[wanted-1].name}"
            puts
            puts "Select a game you want to give:"
            @player.list_games
            giving = gets.chomp.to_i
            puts "You're giving: #{@player.games[giving-1].name}"
            puts
            trade(wanted, giving)
            puts "Trade complete!"
            returning
          else
            puts "You have no games to trade, try shopping for some games first."
            returning
          end
          main_screen
        when 3  #######################################     TOSS GAMES
          clear
          if @player.games.size > 0
            puts "Select a game you'd like to toss:"
            puts "WARNING: Games tossed cannot be restored!"
            puts
            @player.list_games
            toss = gets.chomp.to_i-1
            puts "You're deleting #{@player.games[toss].name}"
            puts "Are you sure you don't want this game anymore?(y/n)"
            answer = gets.chomp
            clear
            if answer == "y"
              @player.remove_game(@player.games[toss])
              elsif answer == "n"
              puts "You chose to not toss #{@player.games[toss].name}..."
              returning
            else
              puts "Invalid selection, returning to main menu"
            end
          else
            puts "You have no games to toss."
            returning
          end
          main_screen
        when 4  #######################################     GIVE GAME
          clear
          if @player.games.size > 0
            puts "SELECT the game you'd like to give to #{@npc.name}"
            @player.list_games
            give = gets.chomp.to_i-1
            clear
            puts "You are giving #{@player.games[give].name} to #{@npc.name}"
            puts
            puts "Are you sure you want to give this game away?(y/n)"
            answer = gets.chomp
            clear
            if answer == "y"
              @npc.add_game(@player.games[give])
              @player.remove_game(@player.games[give])
              puts "Done! you gave away: #{@npc.games.last.name}"
              main_screen
            elsif answer == "n"
              puts "You chose to not give your game away."
              returning
              main_screen
            else
              puts "Invalid answer, #{returning}"
              main_screen
              end
          else
            puts "You have no games to give, try buying some first."
            puts "Returning to main menu"
            main_screen
          end
        when 5  #######################################     TAKE GAME
          puts "Coming soon..."
          main_screen
        when 6 #######################################     CHANGE NAME
          clear
          puts "-----------------------------------CHANGING NAME-----------------------------------"
          puts "Your current name is #{@player.name}"
          puts "What is your new name?"
          @player.name = gets.chomp
          puts "Great! Your new name now is: #{@player.name}!"
          main_screen
        when 7 #######################################      VIEW YOUR GAMES
          clear
          if @player.games.size > 0
            puts "-----------------------------------#{@player.name.upcase}'S   GAMES:-----------------------------------"
            @player.view_game
            puts
          else
            puts "You have no games in your inventory, try buying some games."
            puts "Returning to main menu"
          end
          main_screen
        when 8 #######################################      NPC GAMES
          clear
          puts "------------------------------------NPC's GAMES:-----------------------------------"
          @npc.list_games
          main_screen
        when 9
          clear
          puts "Thanks for playing, #{@player.name}! Goodbye."
          
          puts
          exit
      end
    else
      clear
      puts "Invalid selection, please select a number between 1 and 9"
      main_screen
    end
  end
  
  clear
  @npc = Person.new("NPC Josh")
  Scraper.make_games
  Scraper.cpu_make_games
  
  Scraper.cpugames.each do |game|
    @npc.add_game(game)
  end
  greeting
