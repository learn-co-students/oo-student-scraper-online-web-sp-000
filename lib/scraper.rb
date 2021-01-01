require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    students = []
    
    doc.css(".student-card").each do |student|
       students << {
         :name => student.css("h4.student-name").text,
         :location => student.css("p.student-location").text,
         :profile_url => student.css("a")[0]["href"]

      }
      
      
      
  
    end 
    

    students 
    
    
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    profile_info = {}
    
    all_profile = doc.css("div.social-icon-container a").collect {|e| e.attributes["href"].value} 
    
    all_profile.each do |link|
      
      
      if link.include?("twitter")
        profile_info[:twitter] = link
       
      elsif link.include?("linkedin")
        profile_info[:linkedin] = link
       
      elsif link.include?("github")
         profile_info[:github] = link
      end 
    
      
    end 
    
 
    profile_info[:blog] = all_profile[3] if all_profile[3] != nil
    profile_info[:profile_quote] = doc.css(".profile-quote")[0].text
    profile_info[:bio] = doc.css(".description-holder").css('p')[0].text
    profile_info
  
      

    
  

    
    
  end

end

