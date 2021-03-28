require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student|
      hash = {}
      hash[:name] = student.css(".student-name").text
      hash[:location] = student.css(".student-location").text
      hash[:profile_url] = student.css("a").attribute("href").value
      students << hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
   
    student = {}

    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".main-wrapper.profile .social-icon-container a").each do |profile|
        if profile.attribute("href").value.include?("twitter")
          student[:twitter] = profile.attribute("href").value
        elsif profile.attribute("href").value.include?("linkedin")
          student[:linkedin] = profile.attribute("href").value
        elsif profile.attribute("href").value.include?("github")
          student[:github] = profile.attribute("href").value
        else
          student[:blog] = profile.attribute("href").value
        end
      end

      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css(".description-holder p").text
  
     student
  end
end

