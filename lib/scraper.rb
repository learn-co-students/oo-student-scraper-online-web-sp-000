require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    profiles = []
    doc.css(".student-card").each do |p|
      name = p.css(".student-name").text
      location = p.css(".student-location").text
      profile_url = p.css("a").attr("href").value
      profile = {:name => name, :location => location, :profile_url => profile_url}
      profiles << profile
    end
      profiles
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}

    container = doc.css(".social-icon-container").children.css("a").map {|e| e.attribute("href").value}

    container.each do |url|
      if url.include?("twitter")
        profile[:twitter] = url
      elsif url.include?("linkedin")
        profile[:linkedin] = url
      elsif url.include?("github")
        profile[:github] = url
      else
        profile[:blog] = url
      end
    end

    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text

    profile
  end

end
