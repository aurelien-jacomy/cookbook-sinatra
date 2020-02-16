require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

class ScrapMarmitonService
  def self.call(keyword)
    url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{keyword}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    recipes = []
    doc.search('.recipe-card')[0...5].each do |element|
      name = element.search('.recipe-card__title').text.strip
      description = element.search('.recipe-card__description').text.strip
      prep_time = element.search('.recipe-card__duration').text.strip
      url = "https://www.marmiton.org#{element.css('.recipe-card-link')[0]['href']}"
      # difficulty = find_difficulty(url)
      recipes << Recipe.new(name, description, prep_time)
    end
    return recipes
  end

  private

  def self.find_difficulty(url)
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    doc.search('.recipe-infos__level')[0].text.strip
  end
end
