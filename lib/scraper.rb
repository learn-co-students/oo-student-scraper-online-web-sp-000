require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    # student_card: doc.css("div.student-card")
    # student-name: student_card.css("h4.student-name").text
    # student-location: student_card.css("p.student-location").text
    # 
    binding.pry 
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

