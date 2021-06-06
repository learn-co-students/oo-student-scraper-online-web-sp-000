require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    index_doc = Nokogiri::HTML(open(index_url))

    index_doc.css("div.student-card").each do |student_card|
      student_name = student_card.css(".student-name").text 
      student_location = student_card.css(".student-location").text
      student_url = student_card.css("a").attribute("href").value
      
      students_array << {name: student_name, location: student_location, profile_url: student_url}
    end 
    students_array
  end

  def self.scrape_profile_page(profile_url)
    profile_links = {}
    index_doc = Nokogiri::HTML(open(profile_url))
     
    social_profiles = index_doc.css("div.social-icon-container a").collect {|link| link.attributes["href"].value}
    
    social_profiles.each do |link|
      #binding.pry 
      if link.include?("twitter.com")
        profile_links[:twitter] = link
      elsif link.include?("linkedin.com")
        profile_links[:linkedin] = link
      elsif link.include?("github.com")
        profile_links[:github] = link
      elsif link.include?("facebook.com")
        profile_links[:facebook] = link
      else
        profile_links[:blog] = link
      end 
    end
    
    quote = index_doc.css("div.profile-quote").text
    profile_links[:profile_quote] = quote
    
    bio = index_doc.css(".bio-content.content-holder div.description_holder").text
    profile_links[:bio] = bio 
    
  profile_links
  binding.pry 
  end 

end

