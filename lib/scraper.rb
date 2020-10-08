require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    students = doc.css(".student-card")

    scraped_students = []

    students.each do |student|

      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").text

      scraped_students << student_hash

    end

    scraped_students
  end


  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))

    socials = doc.css(".social-icon-container")
    profile_quote = doc.css(".profile-quote")
    bio = doc.css(".description-holder").first

    scraped_student = {}

    socials.each do |social|

      social_links = social.css("a")

      social_links.each do |social_link|
        social_link_value = social_link.attribute("href").text

        if social_link_value.include? "twitter"
          scraped_student[:twitter] = social_link_value
        elsif social_link_value.include? "linkedin"
          scraped_student[:linkedin] = social_link_value
        elsif social_link_value.include? "github"
          scraped_student[:github] = social_link_value
        else
          scraped_student[:blog] = social_link_value
        end
      end

      scraped_student[:profile_quote] = profile_quote.text
      scraped_student[:bio] = bio.text.strip

    end
    scraped_student
  end

end
