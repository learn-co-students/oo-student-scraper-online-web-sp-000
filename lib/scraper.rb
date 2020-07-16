require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open('https://learn-co-curriculum.github.io/student-scraper-test-page/index.html')
    page = Nokogiri::HTML(html)
    students = []
    
    page.css("div.student-card").each do |student|
      student_details = {}
      student_details[:name] = student.css("h4.student-name").text
      student_details[:location] = student.css("p.student-location").text
      student_details[:profile_url] = student.css("a").first["href"]
      students << student_details
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    page = Nokogiri::HTML(html)
    student_details = {}
    
    
    page.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      
      if social.attribute("href").value.include?("twitter")
        student_details[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_details[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_details[:github] = social.attribute("href").value
      else
        student_details[:blog] = social.attribute("href").value
      end
    end
      
      
      student_details[:profile_quote] = page.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
      student_details[:bio] = page.css("div.main-wrapper.profile .description-holder p").text
    
    student_details
    
  end

end

