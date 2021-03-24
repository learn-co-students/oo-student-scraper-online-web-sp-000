require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css(".student-card").each do |student|
      hash = {}
      hash[:name] = student.css(".student-name").text
      hash[:location] = student.css(".student-location").text
      hash[:profile_url] = student.children.css("a").attribute("href").value
      students << hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    students = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_page.css(".social-icon-container a").each do |url|
      link = url.attributes["href"].value
      if link.include?("twitter")
        students[:twitter] = link 
      elsif  link.include?("linkedin")
        students[:linkedin] = link
      elsif  link.include?("github")
        students[:github] = link
      else
        students[:blog] = link 
      end
    end 
    students[:profile_quote] = profile_page.css(".profile-quote").text 
    students[:bio] = profile_page.css(".description-holder p").text 
    students
  end 

end

