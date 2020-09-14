require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    array_of_students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css("div.student-card")
    students.each do |student|
      hash = {}
      hash[:name] = student.css("h4.student-name").text
      hash[:location] = student.css("p.student-location").text
      hash[:profile_url] = student.css("a").attribute("href").value
      array_of_students << hash
    end
    array_of_students
    
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    links = doc.css("div.social-icon-container a")
    links.each do |link|
      if link.attribute("href").value.include?("twitter")
        hash[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin")
        hash[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github")
        hash[:github] = link.attribute("href").value
      else
        hash[:blog] = link.attribute("href").value
      end
    end
    hash[:profile_quote] = doc.css("div.profile-quote").text
    hash[:bio] = doc.css("div.description-holder p").text
    hash
  end

end

