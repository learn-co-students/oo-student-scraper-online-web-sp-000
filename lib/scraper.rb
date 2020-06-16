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
    scraped_student = {}
    html = Nokogiri::HTML(open(profile_url))
   html.css(".social-icon-container a").each do |link|
    if link.attribute("href").value.include?("twitter")
   scraped_student[:twitter] = link.attribute("href").value
   elsif link.attribute("href").value.include?("linkedin")
   scraped_student[:linkedin] = link.attribute("href").value
  elsif link.attribute("href").value.match("github")
    scraped_student[:github] = link.attribute("href").value
   else 
    scraped_student[:blog] = link.attribute("href").value
   end
  end
    scraped_student[:profile_quote] = html.css("div.profile-quote").text
    scraped_student[:bio] = html.css("div.bio-content.content-holder p").text
   scraped_student
  end

end

