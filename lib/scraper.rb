require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_info = []

    students = doc.css("div.student-card")

    students.each_with_index do |student, index|

      name = student.css("div.card-text-container h4.student-name").children.text.strip
      location = student.css("div.card-text-container p.student-location").children.text.strip
      profile = doc.css("div.student-card a")[index]["href"].strip

      student_bio = {:name => name, :location => location, :profile_url => profile}
      student_info << student_bio
    end
    student_info


  end

  def self.scrape_profile_page(profile_url)

  end

end
