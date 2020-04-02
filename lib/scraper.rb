require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |student|
      hash = {name: student.css(".student-name").text.strip, location: student.css(".student-location").text.strip, profile_url: student.css("a").attribute("href").value}
      students << hash
    end 
    students
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css("a").each do |tag|
      string = tag.attribute("href").value
      string_split = string.split(/\W+/)
      if string_split.include?("twitter")
        hash[:twitter] = string 
      elsif string_split.include?("linkedin")
        hash[:linkedin] = string
      elsif string_split.include?("github")
        hash[:github] = string
      elsif string != "../"
        hash[:blog] = string
      end
    end
    hash[:profile_quote] = doc.css("div.profile-quote").text
    doc.css("div.bio-block").each do |line|
      hash[:bio] = line.css("p").text.strip
    end
    hash
  end

end

