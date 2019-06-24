require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    cards = []
    doc.css(".student-card").each do |card|
    student_hash = {}
      student_hash[:location] = card.css("a div.card-text-container p").text
      student_hash[:name] = card.css("h4").text
      student_hash[:profile_url] = card.css("a").attribute("href").value
      cards << student_hash
      cards
    end 
    cards
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}
    doc.css(".social-icon-container a").each do |element|
      url = element.attribute("href").value 
      if url.include?("github")
        profile[:github] = url
      elsif url.include?("linkedin")
        profile[:linkedin] = url
      elsif url.include?("twitter")
        profile[:twitter] = url
      else url 
        profile[:blog] = url
      end
     profile[:profile_quote] = doc.css("body div div.vitals-container div.vitals-text-container div").text
     profile[:bio] = doc.css("body div div.details-container div.bio-block.details-block div div.description-holder p").text
     profile
     end
    profile
  end
end

