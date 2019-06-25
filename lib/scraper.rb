require 'nokogiri'

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    array = []

    page = Nokogiri::HTML(open(index_url))

    page.css(".student-card").each do |student|
      details = {}
      details[:name] = student.css(".student-name").text
      details[:location] = student.css(".student-location").text
      details[:profile_url] = student.css("a")[0].attributes["href"].value
      array << details
    end
    array
  end

  def self.scrape_profile_page(profile_url)

  end

end
