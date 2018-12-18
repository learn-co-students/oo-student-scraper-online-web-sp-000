require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)
    students = []
    index_page.css("div.student-card").each do |student|
      this_student = {}
      this_student[:name] = student.css("h4.student-name").text
      this_student[:location] = student.css("p.student-location").text
      this_student[:profile_url] = student.css("a").attribute("href").value
      students << this_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
