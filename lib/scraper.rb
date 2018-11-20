require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    array = []
    students.each do |student|
      info = {}
      info[:name] = student.css("h4.student-name").text
      info[:location] = student.css("p.student-location").text
      info[:profile_url] = student.css("a")[0].attributes["href"].value
      array << info
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css(".social-icon-container").css("a")
    quote = doc.css(".profile-quote").text.strip
    bio = doc.css(".description-holder p").text.strip
    info = {}
    info[:bio] = bio
    info[:profile_quote] = quote
    links.each do |link|
      a = link.attributes["href"].value
      if a.include?("twitter")
        info[:twitter] = a
      elsif a.include?("github")
        info[:github] = a
      elsif a.include?("linkedin")
        info[:linkedin] = a
      else
        info[:blog] = a
      end
    end
    info
  end

end
