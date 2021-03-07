require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    page = Nokogiri::HTML(open(index_url))
    page.collect.css("div.roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_profile_id = roster-cards-container.css('.student-profile-id').text
        student << {name: student_name, location: student_location, profile_id: student_profile_id}
      end
    end
    end

  def self.scrape_profile_page(profile_url)

  end

end
