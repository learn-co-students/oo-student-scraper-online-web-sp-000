require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  @@scraped_students = []
  @@student_attributes = {}
  
  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
       
    html.css(".student-card").each do |student| 
      student_name = student.css(".student-name").text 
      student_name_url = student_name.split(" ").join("-").downcase
      student_location = student.css(".student-location").text
      student_profile = "students/#{student_name_url}.html"
      hash = {:name => student_name, :location => student_location, :profile_url => student_profile}
      @@scraped_students << hash 
    end 
      @@scraped_students
   
  end

  def self.scrape_profile_page(profile_url)
    scrape_index_page(profile_url).collect do |student|
     student_attributes = {:name => student_name}
      #binding.pry 
    end 
     
  end

end

