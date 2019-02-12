require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students = []

    doc.css(".student-card").each do |student|
      student_data = {}
      student_data[:name] = student.css("h4.student-name").text
      student_data[:location] = student.css("p.student-location").text
      student_data[:profile_url] = student.css("a").attribute("href").value

      students << student_data

    end

    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student = {}

    all_href = doc.css(".social-icon-container a").collect{ |icon| icon.attribute("href").value}
    all_href.each do |link|
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
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".description-holder p").text

    student
  end

end
