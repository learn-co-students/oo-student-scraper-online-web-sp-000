require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    website = Nokogiri::HTML(open(html))
    student_card = website.css("div.student-card")
    
    student_card.each do |student|
    ind_student = {}
    ind_student[:name] = student.css("h4.student-name").text
    ind_student[:location] = student.css("p.student-location").text
    ind_website = student.children[1].attributes["href"].value
    ind_student[:profile_url] =  ind_website
    students << ind_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

