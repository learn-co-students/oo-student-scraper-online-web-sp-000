require 'nokogiri'

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_profile = doc.css(".student-card")
    student_array = []
    student_profile.each do |element|
    hash = {:name => element.css(".student-name").text, :location => element.css(".student-location").text, :profile_url => element.css("a").first["href"]}
    student_array << hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_profile = doc.css(".vitals-container a")
    profile_quote = doc.css(".vitals-container")
    bio = doc.css(".details-container")
    social_networks = ["twitter", "linkedin", "github", "blog"]
    i = 0
    hash = {}
    social_profile.each do |e|
      hash[social_networks[i].to_sym] = e["href"]
      i += 1
    end
    hash[:profile_quote] = profile_quote.css(".profile-quote").text
    hash[:bio] = bio.css(".description-holder p").text
    hash
  end

end

