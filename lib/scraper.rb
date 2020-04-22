require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_info = []
    # doc.css("div.roster-cards-container").each do |student_card|
      doc.css(".student-card a").each do |info|
        student_info_hash = {
        :name => info.css("h4.student-name").text,
        :location => info.css("p.student-location").text,
        :profile_url => info.attribute("href").text
      }
      student_info << student_info_hash
      end
    # end
    student_info
  end

  def self.scrape_profile_page(profile_url)

  end

end
