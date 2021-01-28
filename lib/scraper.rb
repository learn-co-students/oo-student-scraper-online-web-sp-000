require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  attr_accessor :student

  def self.scrape_index_page(index_url)    
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    students = []
  
    doc.css("div.student-card").each do |a|  
      students << {
      :name => a.css("h4.student-name").text,
      :location => a.css("p.student-location").text,
      :profile_url => a.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)

    student = {}

    links = page.css("div.social-icon-container").children.css("a").map {|element| element.attribute("href").value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else 
        student[:blog] = link 
      end
    end

    
    student[:profile_quote] = page.css(".profile-quote").text if page.css(".profile-quote")
    student[:bio] = page.css("div.bio-content.content-holder div.description-holder p").text if page.css("div.bio-content.content-holder div.description-holder p")

    student

  end

end

