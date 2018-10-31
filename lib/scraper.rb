require 'open-uri'
require 'pry'

require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    users = []

    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |profile|
        profile_link = profile.attribute("href").value
        profile_name = profile.css(".student-name").text
        profile_location = profile.css(".student-location").text

        users << {name: profile_name, location: profile_location, profile_url: profile_link}

      end
      binding.pry
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
