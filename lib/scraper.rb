require 'open-uri'
require 'nokogiri'
require 'pry'
# s.css(".student-name").text
# s.css(".student-location").text
#students.css("a").attribute("href")
# links = students.xpath("//a")
# urls = links.map { |e|  puts "#{e[:href]}"}

class Scraper
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    info = []
      students.each do |s|
        student = {}
        student[:name] = s.css(".student-name").text
        student[:location] = s.css(".student-location").text
        student[:profile_url] = s.css("a").attribute("href").text
        info << student
    end
    info
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
      doc.css(".social-icon-container a").each do |a|
        key = a.attribute("href").text.split(/https:\/\/w*\.?/)[1]
        if key != nil
          key = key.split(/\.com\/\w+/)[0]
          key = key.to_sym
          student[key] = a.attribute("href").text
        else
          student[:blog] = a.attribute("href").text
        end
      end
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css("p").text
    student
  end
end
#puts Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
#Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html")
