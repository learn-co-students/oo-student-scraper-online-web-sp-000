require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    student_card = doc.css(".student-card")
    student_card.each do |student|
      student_info = {}
      student_info[:name] = student.css(".student-name").text
      student_info[:location] = student.css(".student-location").text
      student_info[:profile_url] = student.css("a").first["href"]
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    social = profile.css(".social-icon-container a").collect {|social| social["href"] }
    social_media = {}
    social.each do |profile|
      if profile.include?("twitter")
        social_media[:twitter] = profile
      elsif profile.include?("linkedin")
        social_media[:linkedin] = profile
      elsif profile.include?("github")
        social_media[:github] = profile
      else
        social_media[:blog] = profile
      end
    end
    social_media[:profile_quote] = profile.css("div.profile-quote").text
    social_media[:bio] = profile.css("div.description-holder p").text

    social_media
  end

end
