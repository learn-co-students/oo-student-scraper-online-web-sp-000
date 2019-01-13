require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    
    index_url = File.read('fixtures/student-site/index.html')
    profiles = Nokogiri::HTML(index_url)
    
    students = []
    profiles = {}
    #find name, location and profile url
      
      
      #each profile lives here
      #profiles.css("div.student-card")
      
      profiles.css("div.student-card").each do |profile| 
        
        
        profiles = {:name => profile.css("div.card-text-container h4.student-name").text, :location => profile.css("div.card-text-container p.student-location").text}
        students.push(profiles)
        
      end 
  
    
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

