require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    students = []
    
    page.css("div.student-card").each do |student|
      student_hash = {
      :name => student.css("h4.student-name").text,
      :profile_url => student.css("a").attribute("href").value,
      :location => student.css("p.student-location").text }
      students << student_hash
    end 
     
  # return array of hashes 
  students 
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)
     
    #:twitter div.social-icon-container, href, 0
    #:linkedin div.social-icon-container, href, 1
    #:github div.social-icon-container, href, 2
    #:blog div.social-icon-container, href, 3
    #:profile_quote div.profile-quote
    #:bio 
    
    profile_hash = {}
    
    links = page.css(".social-icon-container").css('a').collect {|link| link.attributes["href"].value}
     
    links.detect do |link| 
        profile_hash[:twitter] = link if link.include?("twitter")
        profile_hash[:linkedin] = link if link.include?("linkedin") 
        profile_hash[:github] = link if link.include?("github")      
      end
     
     profile_hash[:blog] = links[3] if links[3] != nil 
     profile_hash[:profile_quote] = page.css(".profile-quote")[0].text
     profile_hash[:bio] = page.css(".description-holder").css('p')[0].text

      profile_hash
    end 

end

