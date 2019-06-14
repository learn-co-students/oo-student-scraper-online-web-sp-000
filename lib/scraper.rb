require 'open-uri'
require 'pry'

class Scraper
  
 
  def self.scrape_index_page(index_url)
      student_array = []
      student_hash = {}
      index_page = Nokogiri::HTML(open(index_url))
      student_html = index_page.css("div.student-card")
      student_html.each do |student|  
      student_hash = {name: student.css(".student-name").text, location: student.css(".student-location").text, profile_url: student.css("a").attr("href").value}
      
      student_array << student_hash      
    
  end
  
     student_array

  end

  def self.scrape_profile_page(profile_url)
   attributes = {}
   profile_page = Nokogiri::HTML(open(profile_url))
   profile_html = profile_page.css("div.social-icon-container").children
   profile_html.each do |student|  

   attributes = {twitter: profile_html[1].attributes["href"].value, linkedin: profile_html[3].attributes["href"].value, github: profile_html[5].attributes["href"].value, blog: profile_html[7].attributes["href"].value, bio: profile_page.css("div.profile-quote").text}
  
   end 
   attributes
   
  #   profile_html = profile_page.css
  #   binding.pry
  end


end

