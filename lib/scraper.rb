require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |post|
      student = {
        :name => post.css("h4.student-name").text,
        :location => post.css("p.student-location").text,
        :profile_url => post.css("a").attribute("href").value
      }
      students << student
    end
    students
end


  def self.scrape_profile_page(profile_url)
    profile = {}
    doc = Nokogiri::HTML(open(profile_url))
    
    social_media = doc.css(".social-icon-container a").collect do |link|
      link.attribute("href").value
    end
    
    social_media.each do |link|
      case
      when link.include?("twitter")
        profile[:twitter] = link  
      when link.include?("linkedin")
        profile[:linkedin] = link
      when link.include?("github")
        profile[:github] = link
      else  
        profile[:blog] = link
      end
    end
    
    profile[:profile_quote] = doc.css("div.profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text
    profile
  end

end

