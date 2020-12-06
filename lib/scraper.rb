require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".student-card").each do |student|
      student_data = {}
      student_data[:location] = student.css("p.student-location").text
      student_data[:name] = student.css("h4.student-name").text
      student_data[:profile_url] = student.css("a").attribute("href").value
    student_index_array << student_data
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    student_data = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    doc.css(".vitals-container .social-icon-container a").each do |social_media|
      if social_media.attr('href').include?("twitter")
        student_data[:twitter] = social_media.attr('href')
      elsif social_media.attr('href').include?("linkedin")
        student_data[:linkedin] = social_media.attr('href')
      elsif social_media.attr('href').include?("github")
          student_data[:github] = social_media.attr('href')
        elsif social_media.attr('href').include? ("com")
          student_data[:blog] = social_media.attr('href')
    end
  end
    student_data[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
    student_data[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text

    student_data
  end

end
