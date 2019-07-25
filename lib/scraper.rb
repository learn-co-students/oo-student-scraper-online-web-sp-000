# require 'Nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |student|
    student_hash = {}
    student[:location] = doc.css("p.student-location").text
    student[:name] = doc.css("h4.student-name").text
    student[:profile_url] =doc.css("a.href").text
    students << student_hash
  end
    students
# binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
