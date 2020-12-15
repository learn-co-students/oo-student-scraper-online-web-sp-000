require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").collect do |student|
      {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").value
      }
    end 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    #binding.pry
    profile_hash = {}
    social_links = doc.css("div.social-icon-container").children.css("a").map do |l|
      l.attribute("href").value
    end 
    
    social_links.each do |link|
      if link.include?("twitter")
        profile_hash[:twitter] = link 
      elsif link.include?("linkedin")
        profile_hash[:linkedin] = link 
      elsif link.include?("github")
        profile_hash[:github] = link 
      else 
        profile_hash[:blog] = link 
      end
    end 
    
    profile_hash[:profile_quote] = doc.css("div.profile-quote").text 
    
    profile_hash[:bio] = doc.css("div.description-holder p").text
    
    profile_hash
  end
  
end

