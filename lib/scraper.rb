require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    students.each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text.strip
      student_hash[:location] = student.css(".student-location").text.strip
      student_hash[:profile_url] = student.css("a")[0]['href']
      array << student_hash
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}
    links = doc.css(".social-icon-container a")
    links.each do |link|
      url = link['href']
      case
      when url.include?("twitter")
        hash[:twitter] = link['href']
      when url.include?("linkedin")
        hash[:linkedin] = link['href']
      when url.include?("github")
        hash[:github] = link['href']
      else
        hash[:blog] = link['href']
      end
    end
    hash[:profile_quote] = doc.css(".profile-quote").text.strip
    hash[:bio] = doc.css(".description-holder p").text.strip
    hash
  end

end

