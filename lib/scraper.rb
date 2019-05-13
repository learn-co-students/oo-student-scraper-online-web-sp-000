require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student|
      name = student.css("h4").text
      location = student.css("p").text
      url = student.css("a").attribute("href").value
      student = {name:name, location:location, profile_url:url }
      scraped_students.push(student)
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
      scraped_student = Hash.new
      doc = Nokogiri::HTML(open(profile_url))
      doc.css(".social-icon-container").css("a").each do |platform|
      url = platform.attribute("href").value
    if url.include?("twitter") then scraped_student[:twitter] = url
    elsif url.include?("github") then scraped_student[:github] = url
    elsif url.include?("linkedin") then scraped_student[:linkedin] = url
    else scraped_student[:blog] = url
    end
  end
  scraped_student[:profile_quote] = doc.css(".profile-quote").text
  scraped_student[:bio] = doc.css(".description-holder").css("p").text
  scraped_student
  end

end
