require 'open-uri'
require 'pry'



class Scraper

  def self.scrape_index_page(index_url)
    index = open(index_url)
    doc = Nokogiri::HTML((index))
    binding.pry
    
    hash = {}
    doc.css('.student-name').each do
     |element| hash[:name] = element.text
   end


  end

  def self.scrape_profile_page(profile_url)


  end

end
