require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url))
    students_array = []
    students.css(".roster-cards-containter .student-card").map do |student|
    binding.pry
    student_hash = {}
    student_name = student.css("a .card-text-container .student-name, h4")
  end


  end

  def self.scrape_profile_page(profile_url)

  end

end
