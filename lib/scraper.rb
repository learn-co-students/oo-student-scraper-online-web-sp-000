require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    attr_accessor :name
    students_array = []
    
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    cards = doc.css(".student-card").each do |card|
    students_array << {:name => name = card.css("h4").text, :location => location = card.css(".student-location").text, :profile_url => profile_url = card.css("a").attribute("href").value}
    end
    students_array
  end
  
  def self.scrape_profile_page(profile_url)
    student_hash = {}
    
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.social-icon-container a").each do |link|
      if link.attribute("href").value.include?("linkedin")
        student_hash[:linkedin] = link.attribute("href").value
        elsif link.attribute("href").value.include?("twitter")
        student_hash[:twitter] = link.attribute("href").value
        elsif link.attribute("href").value.include?("github")
        student_hash[:github] = link.attribute("href").value
      else
        student_hash[:blog] = link.attribute("href").value
      end
    end
    student_hash[:profile_quote] = doc.css("div.profile-quote").text
    student_hash[:bio] = doc.css("div.bio-content div.description-holder").text.strip
    student_hash
  end

end

