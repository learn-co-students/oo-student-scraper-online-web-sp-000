require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    results = page.css("div.student-card")
    students = []
    results.each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_info = {:name => name, 
      :location => location, 
      :profile_url => profile_url}
      students << student_info
    end
      students
    end
 

 def self.scrape_profile_page(profile_url)
      page = Nokogiri::HTML(open(profile_url))
      student = {}
      links = page.css(".social-icon-container").children.css("a").map {|a| a.attribute('href').value}
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
      student[:bio] = page.css(".description-holder p").text if page.css(".description-holder p")
      
      student
    end
end
