require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    # name = student.css(".student-name").text
    # location = student.css(".student-location").text
    # url = student.css("a").attribute("href").value
    students_array = []
    students.each do |student|
      students_array << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    media_links = doc.css(".social-icon-container a").map do |link|
      link.attribute("href").value
    end
    media_links.each do |link|
      if link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      elsif link.include?("twitter")
        student_hash[:twitter] = link
      else
        student_hash[:blog] = link
      end
    end
    student_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text
    student_hash
  end

end
