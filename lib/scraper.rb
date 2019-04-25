require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
    index.css('div.roster-cards-container').each do |student_card|
      student_card.css('.student-card a').each do |card_content|
        student_name = card_content.css('.student-name').text
        student_location = card_content.css('.student-location').text
        student_url = "#{card_content.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}
    profile_links = profile.css(".social-icon-container").children.css("a").map { |content| content.attribute('href').value}
    profile_links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    student[:bio] = profile.css("p").text
    end
    student
  end
end
