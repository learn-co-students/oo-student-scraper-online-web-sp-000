require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    profile_array = []
    doc = Nokogiri::HTML(open(index_url))
      doc.css(".student-card").each do |card|
        profile = Hash.new
        profile[:name] = card.css(".student-name").text
        profile[:location] = card.css(".student-location").text
        profile[:profile_url] = card.css("a")[0]["href"]
        profile_array << profile
      end
      profile_array
    end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}

    links = doc.css(".social-icon-container").children.css("a").collect {|url| url.attribute("href").value}
      links.each do |link|
        if link.include?("twitter")
          profile_hash[:twitter] = link
        elsif link.include?("linkedin")
          profile_hash[:linkedin] = link
        elsif link.include?("github")
          profile_hash[:github] = link
        else
          profile_hash[:blog] = link
        end
      end
      doc.css(".profile-quote").each do |quote|
        profile_hash[:profile_quote] = quote.text
      end
      doc.css(".description-holder p").each do |p|
        profile_hash[:bio] = p.text
      end
      profile_hash
    end

end
