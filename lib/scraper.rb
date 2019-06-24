require 'nokogiri'

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('http://178.128.177.30:42797/fixtures/student-site/')

    student_roster = Nokogiri::HTML(html)

    hash = {}

    student_roster.css("<div class = "roster-cards-container"> <div>").each do |student|
      

  end

  def self.scrape_profile_page(profile_url)

  end

end
