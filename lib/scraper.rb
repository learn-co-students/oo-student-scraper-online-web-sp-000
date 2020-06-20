require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))

    students = []
    
    page.css("div.student-card").each do |student|
      student_details = {}
      student_details[:name] = student.css("h4.student-name").text
      student_details[:location] = student.css("p.student-location").text
      profile_path = student.css("a").attribute("href").value
      student_details[:profile_url] = profile_path
      students << student_details
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))

    student = {}

    links = page.css("div.social-icon-container a").collect{|icon| icon.attribute("href").value}
    links.each do |link|
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
    student[:profile_quote] = page.css(".profile-quote").text
    student[:bio] = page.css("div.description-holder p").text
    student
  end

end