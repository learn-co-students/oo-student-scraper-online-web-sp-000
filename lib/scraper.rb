require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each do |student|
      student_hash= {}
      student_hash[:name] = student.css(".student-name").text.strip
      student_hash[:location] = student.css(".student-location").text.strip
      student_hash[:profile_url] = student.css("a").first['href']
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    social_links = doc.css(".social-icon-container a")
    
    counter = 0
    while student_profile.length < social_links.length do
      if social_links[counter]["href"].include?("twitter")
        student_profile[:twitter] = social_links[counter]["href"]
      elsif social_links[counter]["href"].include?("linkedin")
        student_profile[:linkedin] = social_links[counter]["href"]
      elsif social_links[counter]["href"].include?("github")
        student_profile[:github] = social_links[counter]["href"]
      else
        student_profile[:blog] = social_links[counter]["href"]
      end
      counter += 1
    end

    student_profile[:profile_quote] = doc.css(".profile-quote").text.strip
    student_profile[:bio] = doc.css(".bio-content.content-holder p").first(p).text
    student_profile
  end

end
