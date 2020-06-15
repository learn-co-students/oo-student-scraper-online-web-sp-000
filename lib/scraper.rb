require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   #index_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"
   students =[]
   doc = Nokogiri::HTML(open(index_url))
   doc.css("div.student-card").each do |student|
   student_info = {
     :name => student.css("h4.student-name").text,
     :location => student.css("p.student-location").text,
     :profile_url => student.css("a").attribute("href").value}
     students << student_info
   end
   students
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
   #html.css("div.social-icon-container")
   binding.pry
  end

end

