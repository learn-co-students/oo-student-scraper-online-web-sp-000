require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    
    students = []
     
    page.css(".roster-cards-container").each do |profile|
       profile.css(".student-card").each do |card|
         student_hash = {
          :profile_url => card.css("a").attribute("href").value,
          :name => card.css(".student-name").text,
          :location => card.css(".student-location").text
        }
        students << student_hash
      end
    end
    return students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
     
    student_hash ={}
    
    # social medias
    page.css(".social-icon-container a").each do |sm|
      
      social = ""
      social = sm.attribute("href").value
  
      if social.include?("twitter")
        student_hash[:twitter] = social
      elsif social.include?("linkedin")
        student_hash[:linkedin] = social
      elsif social.include?("github")
        student_hash[:github] = social
      else
        student_hash[:blog] = social
      end
    end
    
    student_hash[:profile_quote] = page.css(".profile-quote").text
    student_hash[:bio] = page.css(".description-holder p").text
    
    return student_hash
  end

end

