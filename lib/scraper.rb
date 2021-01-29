require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    students.map do |student|
      student_info = Hash.new 
      student_info[:name] = student.css(".card-text-container .student-name").text 
      student_info[:location] = student.css(".card-text-container .student-location").text 
      student_info[:profile_url] = student.css("a").attribute("href").value
      student_info
    end 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    info = Hash.new 
    social_urls = doc.css(".social-icon-container").css("a").map do |account|
      account.attribute("href").value
    end
    social_urls.each do |url|
      if url.include?("twitter")
        info[:twitter] = url 
        elsif url.include?("linkedin")
        info[:linkedin] = url 
        elsif url.include?("github")
        info[:github] = url 
      else 
        info[:blog] = url 
      end
    end     
    info[:profile_quote] = doc.css(".profile-quote").text
    info[:bio] = doc.css(".details-container").css(".description-holder").css("p").text
    info 
  end

end

