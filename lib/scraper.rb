require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    names = []
    doc.css("div.roster-cards-container").each do |r|
      puts r.css(".student_card a .card-text-container h4.student-name").text
      binding.pry

    end



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
