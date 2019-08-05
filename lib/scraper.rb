require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card a")
    student_array = []
    students.each do |student|
      new_hash={}
    new_hash[:name] = student.css("h4.student-name").text.strip
    new_hash[:location] = student.css("p.student-location").text.strip
    new_hash[:profile_url] = student.attribute("href").value
    student_array << new_hash
  end
  student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    profile_hash = {}
    profile_hash[:twitter] = ""
    profile_hash[:linkedin] = ""
    profile_hash[:github] = ""
    profile_hash[:blog] = ""
    profile_hash[:profile_quote] = ""
    profile_hash[:bio] = ""
    profile_hash
    binding.pry
  end

end

