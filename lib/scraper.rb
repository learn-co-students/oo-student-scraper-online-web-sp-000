require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_index_array = []
    
    doc.css("div.student-card").each do |student|
    
    
    
    student_index_array <<  {
      :name => student.search("h4.student-name").text,
      :location => student.search("p.student-location").text,
      :profile_url => student.search("a").first["href"]  
      
    }
  end 
  student_index_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    student_profile = {
      :profile_quote => doc.search("div.profile-quote").text,
      :bio => doc.search("div.description-holder p").text
    }
    
    social = []
    doc.css("div.social-icon-container a").each do |icon|
       social << icon.attribute("href").value
     end 
    social.each do |app_url|
      if app_url.include?("twitter")
        student_profile[:twitter] = app_url
      elsif app_url.include?("linkedin")
        student_profile[:linkedin] = app_url
      elsif app_url.include?("github")
        student_profile[:github] = app_url
      elsif app_url.include?("youtube")
    else 
        student_profile[:blog] = app_url  
    end
  end
    #:twitter => social.search("a")[0]["href"],
    #  :linkedin => social.search("a")[1]["href"],
    #  :github => social.search("a")[2]["href"],
    #  :blog => social.search("a")[3]["href"],
    return student_profile
  end

end

