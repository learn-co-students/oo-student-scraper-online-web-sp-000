require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    index_doc = Nokogiri::HTML(open(index_url))

    index_doc.css("div.student-card").each do |student_card|
      student_name = student_card.css(".student-name").text 
      student_location = student_card.css(".student-location").text
      student_url = student_card.css("a").attribute("href").value
      
      students_array << {name: student_name, location: student_location, profile_url: student_url}
    end 
    students_array
  end

  def self.scrape_profile_page(profile_url)
    scrapped_profile_page = {}
    index_doc = Nokogiri::HTML(open(profile_url))
    index_doc.css("div.social-icon-container").each do |platform|
      
    
  end

end

