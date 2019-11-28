require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    roster_cards = doc.css(".roster-cards-container")

    binding.pry
    puts roster_cards[0]

    # roster_cards.each do |cards|
    #   cards.each do |card|
    #     puts card
    #     binding.pry
    #   end
    # end



  end

  def self.scrape_profile_page(profile_url)

  end

end
