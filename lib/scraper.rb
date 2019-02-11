require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student = doc.css(".student-card").first
    name = student.css(".student-name").text
    location = student.css(".student-location").text
    profile = student.css("a href").text

    binding.pry
=begin
    doc.css(".student-card").first.each do |student|
      student = Student.new
      student.name = student.css(".student-name").text
      student.location = student.css("student-location").text
      student.profile_url = student.css("<a>").text
    end
=end
  end

  def self.scrape_profile_page(profile_url)

  end

end
