require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    students_info = []
    students.each do |student|
      student_profile = {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    students_info << student_profile
    end
    students_info
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_info = {}
    links = doc.css(".social-icon-container a")
    links.each do |link|
      social_key = link.attribute("href").value.match(/(?:https?\:\/\/(?:www\.)?)(\w*)/)[1]
      if social_key == "twitter" || social_key == "linkedin" || social_key == "github"
        student_info[social_key.to_sym] = link.attribute("href").value
      else
        student_info[:blog] = link.attribute("href").value
      end
    end
    student_info[:profile_quote] = doc.css(".profile-quote").text
    student_info[:bio] = doc.css("div.bio-content p").text
    student_info
  end

end
