require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    array_of_student_hashes
    self.get_students(index_url).each do |student_card|
      #student = Student.new
      name = student_card.css("h4.student-name").text
      location = student_card.css("p.student-location").text
      profile_url = student_card.css("a")[0]["href"]

      student_hash = {:name => name, :location => location, :profile_url => profile_url}
      array_of_student_hashes << student_hash
      #puts profile_url
    end
  end


  def self.scrape_profile_page(profile_url)

  end

  def self.get_students(html)
    #puts   self.get_page(html).css(".student-card")
    self.get_page(html).css(".student-card")
  end

  def self.get_page(html)
    doc = Nokogiri::HTML(URI.open(html))
  end
end

Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/")
