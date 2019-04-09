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
    link=doc.css("div.social-icon-container a").attribute("href").value
    profile[:twitter]=link if link.include?("twitter")
    profile[:linkedin]=link if link.include?("linkedin")
    profile
  end

end

