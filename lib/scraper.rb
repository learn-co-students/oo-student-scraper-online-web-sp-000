require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card a")
    student_array = []
    students.each do |student|
      new_hash={}
    new_hash[:name] = student.css("h4.student-name").text.strip
    new_hash[:location] = student.css("p.student-location").text.strip
    new_hash[:profile_url] =  student.attribute("href").value
    student_array << new_hash
  end
  student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_media = doc.css(".social-icon-container a")
    profile_hash = {}
    social_array = []
    social_media.css("a").each do |social|
      social_array << social.attribute("href").value
    end
    
    social_array.each do |social|
      if social.include?("twitter")
      profile_hash[:twitter] = social
    elsif social.include?("linkedin")
      profile_hash[:linkedin] = social
      elsif social.include?("github")
      profile_hash[:github] = social
      elsif social.include?("http://")
      profile_hash[:blog] = social
    end
    
    profile_hash[:profile_quote] = doc.css(".profile-quote").text.strip
    profile_hash[:bio] = doc.css(".description-holder p").text.strip
  end
    profile_hash
  end
  end

