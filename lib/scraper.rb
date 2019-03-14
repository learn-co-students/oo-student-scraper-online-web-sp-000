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
      doc = Nokogiri::HTML(open("./fixtures/student-site/students/david-kim.html"))
      social = doc.css("a")
      number = social.count
    
          binding.pry
  
      social.each do 
        
        

    
      twitter = social[0]["href"] unless social[0]["href"].include?("twitter") == false 
      twitter = social[1]["href"] unless social[1]["href"].include?("twitter") == false
      twitter = social[2]["href"] unless social[2]["href"].include?("twitter") == false
      twitter = social[3]["href"] unless social[3]["href"].include?("twitter") == false 
      twitter = social[4]["href"] unless social[4]["href"].include?("twitter") == false 
      
      binding.pry
    
  end

end

