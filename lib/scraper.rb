require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
    student_hash_arr = []
    
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    
    students.each do |student|
      
      student_hash = {}
      student_hash[:name] = student.css("h4.student-name").text
      student_hash[:location] = student.css("p.student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      
      student_hash_arr << student_hash
      
    end
    
   #binding.pry
   student_hash_arr
    
  end

  def self.scrape_profile_page(profile_url)
    
    doc = Nokogiri::HTML(open(profile_url))
    socials = doc.css(".social-icon-container a")
    
    
    
    student = {}
    socials_arr = []
    
    socials.each do |social|
      
      socials_arr << social.attribute("href").value
      
    end
    
    
    socials_arr.each do |url|
      #binding.pry
      
      if (url.include?("twitter"))
        student[:twitter] = url
      elsif (url.include?("linkedin"))
        student[:linkedin] = url
      elsif (url.include?("github"))
        student[:github] = url
      else
        student[:blog] = url
      end
      
      
    end
  
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".description-holder p").text
    
    #binding.pry
    
    student
    
    
  end

end

