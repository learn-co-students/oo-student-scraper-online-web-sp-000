require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

#Iterate thru students
  def self.scrape_index_page(index_url)
     students = []
     doc = Nokogiri::HTML(open(index_url))

     doc.css("div.student-card").each do |student|
    #  title = student.css("div.student-card").text
     student_details = {
       :name => student.css("h4.student-name").text,
       :location => student.css("p.student-location").text,
       :profile_url => student.css("a").attribute("href").value
     }
     students << student_details
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    
    doc.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end


      student_profile[:profile_quote] = doc.css("div.profile-quote").text
      student_profile[:bio] = doc.css(".description-holder p").text

    end
    student_profile
    end

end
