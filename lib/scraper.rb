require 'open-uri'
require 'nokogiri'
require 'pry'
require 'resolv-replace'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students_array = []

    doc.css(".student-card").each do |student|
      student_hash = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a/@href").first.value
      }
      students_array << student_hash
    end

    students_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile_hash = {}

    social_links = doc.css(".social-icon-container").children.css("a").map {|element| element.attribute('href').value}
    social_links.each do |link|
      if link.include?("twitter")
        student_profile_hash[:twitter] = link
      elsif link.include?("linkedin")
        student_profile_hash[:linkedin] = link
      elsif link.include?("github")
        student_profile_hash[:github] = link
      else
        student_profile_hash[:blog] = link
      end
    end

    student_profile_hash[:profile_quote] = doc.css(".vitals-text-container").css(".profile-quote").text
    student_profile_hash[:bio] = doc.css(".bio-content").css("p").text

    student_profile_hash
  end

end
