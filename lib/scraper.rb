require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |card|
    card.css(".student-card a").each do |student|
      student_profile = "#{student.attr("href")}"
      student_location = student.css(".student-location").text
      student_name = student.css(".student-name").text
      students << {name: student_name, location: student_location, profile_url: student_profile}
      end
    end
    students
  end

  # profile_url = doc.css(".student-card").css("a").attribute("href").value
  # location = doc.css(".student-card").css(".student-location").text
  # name = doc.css(".student-card").css(".student-name").text


  def self.scrape_profile_page(profile_url)
    students_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    social_links = doc.css(".social-icon-container").children.css("a").map { |links| links.attribute("href").value}
    social_links.each do |link|
      if link.include?("twitter")
        students_hash[:twitter] = link
      elsif link.include?("linkedin")
        students_hash[:linkedin] = link
      elsif link.include?("github")
        students_hash[:github] = link
      else
        students_hash[:blog] = link
        # student.css("img").attribute("src").text.include?("rss")
      end
    end
        students_hash[:profile_quote] = doc.css(".main-wrapper").css(".vitals-container").css(".profile-quote").text
        students_hash[:bio] = doc.css(".details-container").css(".description-holder").css("p").text
        students_hash
  end
end
