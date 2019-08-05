require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card a")
    students.each do |student|
    student_name = student.css("h4.student-name").text.strip
    binding.pry
  end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

