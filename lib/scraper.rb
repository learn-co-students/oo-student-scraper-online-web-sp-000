require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index = Nokogiri::HTML(open(index_url))
    index.css("div.student-card").each do |student|
      student_info = {
        name: student.css(".student-name").text, 
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
      students << student_info
    end
    students   
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    index = Nokogiri::HTML(open(profile_url))
    container = index.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
    container.each do |link|
      if link.include?("twitter")
        student[:twitter] = link 
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?(".com")
        student[:blog] = link
      end
    end
    student[:profile_quote] = index.css(".profile-quote").text
    student[:bio] = index.css("div.description-holder p").text
    student
  end
end 
