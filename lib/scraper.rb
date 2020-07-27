require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students_array = []
    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".card-text-container").css(".student-name").text
      student_hash[:location] = student.css(".card-text-container").css(".student-location").text
      student_hash[:profile_url] = student.css("a[href]").first['href']
      students_array << student_hash
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_hash = {}
    all_socials = doc.css(".social-icon-container")
    count = 0
    doc.css(".social-icon-container").css("a[href]").each do |social|
      if social['href'] && social['href'].include?("twitter")
        student_hash[:twitter] = social['href']
      end
      if social['href'] && social['href'].include?("linkedin")
        student_hash[:linkedin] = social['href']
      end
      if social['href'] && social['href'].include?("github")
        student_hash[:github] = social['href']
      end
      if social['href'] && !social['href'].include?("twitter") && !social['href'].include?("linkedin") && !social['href'].include?("github")
        student_hash[:blog] = social['href']
      end
      count += 1
    end
    student_hash[:profile_quote] = doc.css(".vitals-text-container").css(".profile-quote").text
    student_hash[:bio] = doc.css(".bio-content.content-holder").css(".description-holder").text.strip
    student_hash

  end

end

