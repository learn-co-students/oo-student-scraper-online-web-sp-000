require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    html = File.read(index_url)
    index = Nokogiri::HTML(html)
    index.css(".student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      url = "students/#{name.downcase.split.join("-")}.html"
      student = {name: name, location: location, profile_url: url}
      student_array << student
    end
    
    student_array
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

