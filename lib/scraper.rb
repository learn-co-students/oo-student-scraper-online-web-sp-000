require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    Array.new
     doc = Nokogiri::HTML(open(index_url))
     index_array = Array.new
     index_collection = Hash.new

     doc.css(".student-card").each do |card|
       index_collection[:name] = card.css("h4.student-name").text
       index_collection[:location] = card.css("p.student-location").text
       index_collection[:profile_url] = card.xpath('//div/a/@href')[0].text
        binding.pry
       index_array << index_collection
     end
  end

# Name
# Location
# Profile URL

  def self.scrape_profile_page(profile_url)
    
  end

end
