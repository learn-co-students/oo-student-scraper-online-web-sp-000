require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  # KEYS FOR HASHES ARE :NAME, :LOCATION, :PROFILE_URL
  
  def self.scrape_index_page(index_url)
    Nokogiri::HTML(open(index_url))
      # profiles = [
        
      # ]
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

# {:name => "Abby Smith", 
# :location => "Brooklyn, NY", 
# :profile_url => "students/abby-smith.html"},
# Scraper.scrape_index_page('https://learn-co-curriculum.github.io/student-scraper-test-page/index.html').css('.student-name').collect do |student|
#  puts hash = {
#     name: student.text
#   }
# end
flatiron = 'https://learn-co-curriculum.github.io/student-scraper-test-page/index.html'

Scraper.scrape_index_page(flatiron).css(".student-card").collect do |s| 
  puts s.css[]
  # hash = {
  #   name: s.css('.student-name').text, 
  #   location: s.css('.student-location').text,
  #   profile_url: s.css('a href').attributes
  #   } 
  #   puts hash
end
