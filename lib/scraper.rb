require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
   @@all=[]
  def self.scrape_index_page(index_url)
    html=open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.student-card").each do |student|
      s={:name => student.css("h4.student-name").text,:location => student.css("p.student-location").text,:profile_url => student.css("a").attribute("href").value}
      @@all<< s
    end
    @@all
  end

  def self.scrape_profile_page(profile_url)
    profile={}
    html=open(profile_url)
    doc = Nokogiri::HTML(html)
    links=doc.css("div.social-icon-container a")
    links.each do |link|
      address=link.attribute("href").value
        profile[:twitter]=address if address.include?("twitter")
        profile[:linkedin]=address if address.include?("linkedin")
        profile[:github]=address if address.include?("github")
        profile[:blog]=address if address.include?("joemburgess")
        
    end
        profile[:profile_quote]=doc.css("div.profile-quote").text
        profile[:bio]=doc.css("div.description-holder p").text
    profile
  end

end

