require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
     cards = []
      student_hash = {}
        student_hash = doc.css(".student-card")
          student_hash.each do |card|
            student_hash[:name] = card.css("h4").text
      #student_card[:profile_location]
    cards << student_hash
    binding.pry
    cards
   end 
   cards
  end

  def self.scrape_profile_page(profile_url)
    #profile_url.each 
     #if
  end

end

