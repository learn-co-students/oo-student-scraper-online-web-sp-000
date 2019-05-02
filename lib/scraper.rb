require 'open-uri'
require 'pry'



class Scraper

  def self.scrape_index_page(index_url)
    index = open(index_url)
    doc = Nokogiri::HTML((index))
    binding.pry
    
    array = []
    doc.css('.roster-cards-container').each do  |roster_cards_container| 
      roster_cards_container.css('.student-card').each do |student_card|
        array << {:name => student_card.css('.student-name').text, :location => student_card.css('.student-location').text, :profile_url => student_card.css('#block a')[0]["href"] }
      end
   end


  end

  def self.scrape_profile_page(profile_url)


  end

end

