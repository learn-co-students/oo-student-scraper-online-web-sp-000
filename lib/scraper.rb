require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    students = []
    html.css("div.student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4.student-name").text
      student_hash[:location] = student.css("p.student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    html = Nokogiri::HTML(open(profile_url))

    html.css("div.main-wrapper.profile div.vitals-container div.social-icon-container a").each do |icon|
      if icon.attribute("href").value.include?("twitter")
        student[:twitter] = icon.attribute("href").value
      elsif icon.attribute("href").value.include?("github")
        student[:github] = icon.attribute("href").value
      elsif icon.attribute("href").value.include?("linkedin")
        student[:linkedin] = icon.attribute("href").value
      else
        student[:blog] = icon.attribute("href").value
      end
    end

    student[:profile_quote] = html.css("div.main-wrapper.profile div.vitals-container div.vitals-text-container div.profile-quote").text
    student[:bio] = html.css("div.main-wrapper.profile div.description-holder p").text

    student

  end

end
