require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open('./fixtures/student-site/index.html'))
    
    html.css(".student-card").each do |student| 
      binding.pry 
      student.css("#id")
    end 

   
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

