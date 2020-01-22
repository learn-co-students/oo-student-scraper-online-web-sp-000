require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css(".roster-cards-container").css(".student-card")
    student_cards.collect do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text #gets the name element
      student_hash[:location] = student.css(".student-location").text #gets the location element
      student_hash[:profile_url] = student.css("a").attribute("href").value #gets the profile url element
      student_hash
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_links = doc.css(".social-icon-container a").collect {|a| a.attribute("href").value}
    student_hash = {}
    ["twitter", "linkedin", "github"].each do |social_name|
      link = social_links.find {|link| link.include?(social_name)}
      student_hash[social_name.to_sym] = link unless link == nil
      social_links.delete(link)
    end
    student_hash[:blog] = social_links.last unless social_links.empty?
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".bio-block p").text
    student_hash
  end

end
