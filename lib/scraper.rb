require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    
    students = []
    
    doc.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_info = {:name => name, :location => location, :profile_url => profile_url}
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    profiles = {} 
    
    social = doc.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
    social.each do |link|
      if link.include?("twitter")
        profiles[:twitter] = link
        elsif link.include?("linkedin")
        profiles[:linkedin] = link 
        elsif link.include?("github")
        profiles[:github] = link 
        elsif link.include?(".com")
        profiles[:blog] = link 
      end 
    end
      profiles[:profile_quote] = doc.css(".profile-quote").text 
      profiles[:bio] = doc.css("div.description-holder p").text 
      profiles
  end

end


