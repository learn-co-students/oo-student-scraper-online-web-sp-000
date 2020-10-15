require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    result = []
    doc.css(".student-card a").each do |student|
     info = {
        :name => student.css("h4").text,
        :location => student.css("p.student-location").text,
        :profile_url => student["href"]
      }
      result << info
    end
    result
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    info = {}
    doc.css(".social-icon-container a").each do |site|
      if site["href"].include?("twitter")
        info[:twitter] = site["href"]
      elsif site["href"].include?("linkedin")
        info[:linkedin] = site["href"]
      elsif site["href"].include?("github")
        info[:github] = site["href"]
      else
        info[:blog] = site["href"]
      end
    end
    info[:profile_quote] = doc.css(".profile-quote").text
    info[:bio] = doc.css(".description-holder p").text
    info
  end
end

#doc.css(".student-card a")
#name: .css("h4").text
#location:.css("p.student-location").text
#profile-url: ["href"]

#social media stuff:
#doc.css(".social-icon-container a")[0]["href"]

#profile-quote
#doc.css(".profile-quote").text

#bio
#doc.css(".description-holder p").text