require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    
    index_url = File.read('fixtures/student-site/index.html')
    profiles_page = Nokogiri::HTML(index_url)
    
    students = []
    profile_hash = {}
    #find name, location and profile url
      
      
      #each profile lives here
      #profiles.css("div.student-card")
      
      profiles_page.css("div.student-card").each do |profile| 
        
        profile_hash = {:name => profile.css("div.card-text-container h4.student-name").text, :location => profile.css("div.card-text-container p.student-location").text, :profile_url => profile.css("a").attribute("href").value}
        
        students << profile_hash
        
        
      end 
    return students
  end

  def self.scrape_profile_page(profile_url)
    
    
  end

end

