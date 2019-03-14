require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    array = []
    
    students.each do |student|
      s = {name: student.css("h4").text, location: student.css("p.student-location").text, profile_url: student.css("a").first["href"]
      }
      
      array << s 
    end
    
    array 
    
    
  end

  def self.scrape_profile_page(profile_url)
      doc = Nokogiri::HTML(open(profile_url))
      
      if doc.css("a")[1]["href"] == [] 
        
        array = {
          profile_quote: doc.css(".profile-quote").text, 
          bio: doc.css("p").text 
        }
        
      else
        
      array = { 
        twitter: doc.css("a")[1]["href"],
        linkedin: doc.css("a")[2]["href"],
        github: doc.css("a")[3]["href"], 
        blog: doc.css("a")[4]["href"], 
        profile_quote: doc.css(".profile-quote").text, 
        bio: doc.css("p").text 
      }

  end

end

