require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url
  
  # get student names: doc.css("div h4.student-name").text.strip
  # get locations: doc.css("p.student-location").text.strip
  # get profile urls: doc.css("div.student-card a").map {|link| link["href"]}

  def self.scrape_index_page(index_url)
    # responsible for scraping the index page that lists 
    # all of the students
    binding.pry
    doc = Nokogiri::HTML(open(index_url))
    # gets student names 
    student_names = doc.css("div h4.student-name").text.strip
    student_locations = doc.css("p.student-location").text.strip
    student_profile_urls = doc.css("div.student-card a").map {|link| link["href"]}.join(" ").strip
    # gets each student name stored in array 
    student_names.split.each do |name| 
      
    end 
    # binding.pry 
  end

  def self.scrape_profile_page(profile_url)
    # responsible for scraping an individual student's profile page 
    # to get further info about that student 
  end

end

