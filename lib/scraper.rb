require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    student_index_page = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/"))
    scraped_students = []
    student_index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        scraped_students_name = student.css(".student-name").text
        scraped_students_location = student.search(".student-location").text
        scraped_students_profile_url = "#{student.attr('href')}"
        scraped_students << {name: scraped_students_name, location: scraped_students_location, profile_url: scraped_students_profile_url}
      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    social_links = profile_page.css(".social-icon-container a").map { |e| e.attribute("href").value }
    social_links.each do |links|
      if links.include?("twitter")
        scraped_student[:twitter] = links
      elsif links.include?("linkedin")
        scraped_student[:linkedin] = links
      elsif links.include?("github")
        scraped_student[:github] = links
      else
        scraped_student[:blog] = links
      end
    end
    scraped_student[:profile_quote] = profile_page.css(".profile-quote").text
    scraped_student[:bio] = profile_page.css(".description-holder p").text
    scraped_student
  end

end
