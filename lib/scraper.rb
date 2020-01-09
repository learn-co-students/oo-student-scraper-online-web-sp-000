require 'open-uri'
require 'pry'

class Scraper
  
  # get student attributes: doc.css("div.roster-cards-container")
  # get student names: doc.css("div h4.student-name").text.strip
  # get locations: doc.css("p.student-location").text.strip
  # get profile urls: doc.css("div.student-card a").map {|link| link["href"]}
  
  
  def self.scrape_index_page(index_url)
    # responsible for scraping the index page that lists 
    # all of the students
    # binding.pry
    doc = Nokogiri::HTML(open(index_url))
    # gets student names 
    
    doc.css("div.student-card").collect do |student|
      {
        :name => student.css("div h4.student-name").text.strip,
        :location => student.css("p.student-location").text.strip,
        :profile_url => student.css("a").map {|link| link["href"]}.join(" ").strip 
      }
    end 
      
    #   student_index_array << student_index_hash 
      
    # student_names = doc.css("div h4.student-name").text.strip
    # student_locations = doc.css("p.student-location").text.strip
    # student_profile_urls = doc.css("div.student-card a").map {|link| link["href"]}.join(" ").strip
    # binding.pry 
    # vstudent_names.split.each{|name| self.send((:name), name)} 
    # gets each student name stored in array 
    # binding.pry 
    # student_index_array
  end

  def self.scrape_profile_page(profile_url)
    # responsible for scraping an individual student's profile page 
    # to get further info about that student 
      
  end

end

