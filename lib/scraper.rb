require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    scraped_students = []

    student_card = doc.css("div.student-card").first
    student_card.each do |student|

      student_data = {
        :name => student_card.css(".student-name").text,
        :location => student_card.css(".student-location").text,
        :profile_url => student_card.css("a").attribute("href").value
      }

      scraped_students << student_data
    end

    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
