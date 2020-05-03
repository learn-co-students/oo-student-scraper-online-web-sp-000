require 'nokogiri'

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_profile = doc.css(".student-card")
    student_array = []
    student_profile.each do |element|
    hash = {:name => element.css(".student-name").text, :location => element.css(".student-location").text, :profile_url => element.css("a").first["href"]}
    student_array << hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

