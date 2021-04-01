require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :student
  
  def self.scrape_index_page(index_url)
    html = open(index_url)
    nested_doc = Nokogiri::HTML(html)
    students = nested_doc.css("div.student-card")

    student_array = []
    students.each do |student|
      student_array << {
        :name => student.css("h4.student-name").text.strip,
        :location => student.css("p.student-location").text.strip,
        :profile_url => student.children[1].attributes["href"].value
      }
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    nested_doc = Nokogiri::HTML(html)
    student_social = {}
    student_profile = nested_doc.css(".social-icon-container").css('a')
    social_media = student_profile.collect {|social_m| social_m.attributes["href"].value}
      social_media.find do |scraped_media|
        student_social[:twitter] = scraped_media if scraped_media.include?("twitter")
        student_social[:linkedin] = scraped_media if scraped_media.include?("linkedin")
        student_social[:github] = scraped_media if scraped_media.include?("github")
      end
    student_social[:blog] = social_media[3] if social_media[3] != nil
    student_social[:bio] = nested_doc.css(".description-holder").css('p')[0].text.strip
    student_social[:profile_quote] = nested_doc.css(".profile-quote")[0].text
    student_social
  end
end
