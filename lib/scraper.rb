require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)

    doc = Nokogiri::HTML(html)
    doc.css(".student-card").each do |student|
    student_name = student.css(".student-name").text
    student_location = student.css(".student-location").text
    student_url = student.css("a").attr("href").value
    student_info = {
      :name => student_name,
      :location => student_location,
      :profile_url => student_url
    }

    students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_profile =  {}


    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    #student_profile[:blog] = "http://flatironschool.com",

    doc.css(".social-icon-container a").each do |url|
      social_feed = url.attr("href")

      if social_feed.include?("twitter")
        student_profile[:twitter] = social_feed
      elsif
        social_feed.include?("linkedin")
        student_profile[:linkedin] = social_feed
      elsif
        social_feed.include?("github")
        student_profile[:github] = social_feed

      elsif
        social_feed.include?(".com")
        student_profile[:blog] = social_feed
      end
    end
    student_profile[:profile_quote] = doc.css(".profile-quote").text.strip
    student_profile[:bio] = doc.css(".description-holder p").text
    student_profile
    #binding.pry
  end
end
