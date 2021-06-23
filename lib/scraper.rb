require "nokogiri"
require "open-uri"
#require 'pry'

class Scraper

  @cpugames = []

  def self.get_page
    html = open("https://www.alphabetagamer.com")
    doc = Nokogiri::HTML(html)
    doc
    #Titles ====== get_page.css(".entry-title a")
    #Descriptions ====== get_page.css(".entry-content p")
  end

  def self.cpu_get_page
      html = open("https://www.alphabetagamer.com/page/5/")
    doc = Nokogiri::HTML(html)
    doc
    #Titles ====== get_page.css(".entry-title a")
    #Descriptions ====== get_page.css(".entry-content p")
  end

  def self.descriptions
    arr = []
    desc = get_page.css(".entry-content p")

    desc.each do |item|
      if item.text != ""
        arr << item.text
      end
    end
    arr
  end


  def self.list_games
    index = 1
    all_games.each do |title, description|
      puts "#{index}. #{(title)}"
      puts "#{description.values.first}"
      puts ""
      puts ""
      index += 1
    end
  end

  def self.all_games
    games = {}
    p1 = 0
    p2 = 1
    get_page.css(".entry-title a").each do |entry|
      title = entry.text
      #binding.pry
      games[title.to_sym] = {
      :description => descriptions[p1] + " " + descriptions[p2]
      }
      p1 += 2
      p2 += 2
    end
    games
  end

  def self.cpu_games
    games = {}
    p1 = 0
    p2 = 1
    cpu_get_page.css(".entry-title a").each do |entry|
      title = entry.text
      #binding.pry
      games[title.to_sym] = {
        :description => descriptions[p1] + " " + descriptions[p2]
      }
      p1 += 2
      p2 += 2
    end
    games
  end

  def self.make_games
    all_games.each do |game|
      Games.new(game[0], game[1])
    end
    all_games.clear
  end


  def self.cpugames
    @cpugames
  end

  def self.cpu_make_games
    cpu_games.clear
    cpu_games.each do |game|
      a = Games.new(game[0], game[1])
      @cpugames << a
      Games.all.delete(a)
    end
  end

end
