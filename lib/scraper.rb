require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    list = Nokogiri::HTML(html)
    names = list.css("div.student-card a"). each do |student|
     info = {}
     info[:name] = student.css("h4.student-name").text
     info[:location] = student.css("p.student-location").text
     info[:profile_url] = student.attr("href")
     students << info
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
