require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    students = []
    
    doc.css(".student-card").each do |student|
      student_name = student.css("h4").text
      student_location = student.css("p").text
      student_profile_url = student.css("a").attribute("href").text
      students << { :name => student_name, :location => student_location, :profile_url => student_profile_url }
    end
    students
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
    profile = {}

    links = doc.css(".social-icon-container a").map { |link| link.attribute("href").value }
    
    links.each do |link|
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end
     
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text

    profile
  end
end

