require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_profile_link = "#{student.attr('href')}"
      #  student_profile_id = roster-cards-container.css('.student-profile-id').text
        students << {location: student_location, name: student_name, profile_url: student_profile_link}
      end
    end
    students
    end

  def self.scrape_profile_page(profile_url) # is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student (FAILED - 1)
    student = {}
    student_page = Nokogiri::HTML(open(profile_url))
    social_links = student_page.css('social-icon-container').children.css("a").map { |social| social.attribute('href').value}
    social_links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = student_page.css(".profile-quote").text if student_page.css(".profile-quote")
    student[:bio] = student_page.css("div.bio-content.content-holder div.description-holder p").text if student_page.css("div.bio-content.content-holder div.description-holder p")
    student
end
end
