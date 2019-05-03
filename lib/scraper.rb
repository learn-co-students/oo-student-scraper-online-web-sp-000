require 'open-uri'
require 'pry'



class Scraper

  def self.scrape_index_page(index_url)
    index = open(index_url)
    doc = Nokogiri::HTML((index))
    
    
    array = []
    doc.css('.roster-cards-container').each do  |roster_cards_container| 
      roster_cards_container.css('.student-card a').each do |student_card|
        array << {:name => student_card.css('.student-name').text, :location => student_card.css('.student-location').text, :profile_url => student_card.attr("href") }        
      end
   end
  array

  end

  def self.scrape_profile_page(profile_url)
    profile = open(profile_url)
    doc = Nokogiri::HTML((profile))
    {:twitter => doc.css('.social-icon-container a')[0].attr("href"), :linkedin => doc.css('.social-icon-container a')[1].attr("href"), :github => doc.css('.social-icon-container a')[2].attr("href"), :blog => doc.css('.social-icon-container a')[3].attr("href"), :profile_quote => doc.css('.profile-quote').text, :bio => doc.css('.description-holder p').text }

  end

end

