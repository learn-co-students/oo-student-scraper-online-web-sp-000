require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    new_array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".roster-cards-container").each do |student|
      student.css(".student-card a").each do |value|
        profile_url = value.attr("href")
        name = value.css(".student-name").text
       
        location = value.css(".student-location").text
        binding.pry
        new_hash = { :name => value.css(".student-name").text
    
        end
    end 
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

