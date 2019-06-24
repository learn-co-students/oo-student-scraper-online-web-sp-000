require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_card = doc.css(".student-card")
    cards = []
    student_card.each do |card|
     student_card[:name] = card.css("h4 student-card").text
    cards << student_card
    cards
   end 
   cards
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

