require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index = Nokogiri::HTML(html)
    students = []
    student_card = index.css("div.student-card")
    index.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css("h4").text
        student_location = student.css("p").text
        student_profile_link = student.attr("href")
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    student = {}
    socials = profile.css("div.social-icon-container").children.css("a")
    socials.each do |social|
      if social.attr("href").include?("twitter")
        student[:twitter] = social.attr("href")
      elsif social.attr("href").include?("linkedin")
        student[:linkedin] = social.attr("href")
      elsif social.attr("href").include?("github")
        student[:github] = social.attr("href")
      else
        student[:blog] = social.attr("href")
      end
    end
    student[:profile_quote] = profile.css("div.profile-quote").text
    student[:bio] = profile.css("p").text
    student
  end

end
