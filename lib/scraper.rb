# require 'Nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |student|
    student_info = {}
    student_info[:location] = student.css("p.student-location").text
    student_info[:name] = student.css("h4.student-name").text
    student_info[:profile_url] = student.css("a").attribute("href").value
    students << student_info
  end
    students
# binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
