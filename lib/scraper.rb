require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    students_array = []
    doc.css(".roster-cards-container .student-card").each do |student| 
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      students_array << {name: name, location: location, profile_url: profile_url}
    end
      students_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    student_hash = {}  
      
    doc.css(".social-icon-container").each do |social_media|
      twitter = social_media.css("a").attribte("href").value
      linkedin = s
      binding.pry
   # end  
  

end
