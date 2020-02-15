class ScrapMarmitonService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{@keyword}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    recipes = []
    doc.search('.recipe-card')[0...5].each do |element|
      recipes << {
        name: element.search('.recipe-card__title').text.strip,
        description: element.search('.recipe-card__description').text.strip,
        prep_time: element.search('.recipe-card__duration').text.strip,
        url: "https://www.marmiton.org/#{element.css('.recipe-card-link')[0]['href']}",
        difficulty: find_difficulty("https://www.marmiton.org#{element.css('.recipe-card-link')[0]['href']}")
      }
    end
    return recipes
  end

  def find_difficulty(url)
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    doc.search('.recipe-infos__level')[0].text.strip
  end
end
