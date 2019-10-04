 require 'pry'
require 'open-uri'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
      
    doc = Nokogiri::HTML(open(index_url))
    
     students = Array.new
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = "#{student.attr("href")}"
        students << {name: name, location: location, profile_url: profile_url}
      end
    end
    students
  end	   
  
  #students:  "div.roster-cards-container"
  #name: student.css("h4.student-name").text 
  #location: student.css("p.student-location").text 
  #URL: student.css("view-profile-div").text 
     

   

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    scraped_student = Hash.new 
    
    icons = doc.css("div.social-icon-container a").collect do |social| 
      social.attribute("href").value
      #icons is an array of each social media object)
    end 
    
        icons.each do |link|
        ##link is just a URL
        
        if link.include?("twitter")
          scraped_student[:twitter] = link 
       
        elsif link.include?("linkedin")
          scraped_student[:linkedin] = link 
        
        elsif link.include?("github.com")
          scraped_student[:github] = link 
    
        else 
          scraped_student[:blog] = link 
        
        
  #scraped_student now returns a hash with the 3 socials. In same way please add quote and bio.    
        end #block end 
        end #conditional end 
    
      quote = doc.css("div.profile-quote").text
      scraped_student[:profile_quote] = "#{quote}"
    
      bio = doc.css("div.bio-content .description-holder p").text 
      scraped_student[:bio] = bio
    
      scraped_student 
  end #method end 
    
end #class end 
  
  
  
  

  
   
