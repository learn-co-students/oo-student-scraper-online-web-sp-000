# require 'Nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    student = {}
    doc = Nokogiri::HTML(open(index_url))
    doc.search("div.student-card").each do |student|
    student[:location] = doc.search("p.student-location").text
    student[:name] = doc.search("h4.student-name").text
    student[:profile_url] =doc.search("a.href").text
    students << student
  end
    students
# binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
