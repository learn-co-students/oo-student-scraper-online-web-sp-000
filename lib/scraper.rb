require 'open-uri'
require 'pry'

require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = []

    index = Nokogiri::HTML(open(index_url))

    index.css("div.roster-cards-container").each do |profile|
      profile.css("div.student-card a").each do |student|
        profile_link = student.attribute("href").value
        profile_location = student.css(".student-location").text
        profile_name = student.css(".student-name").text

        profiles << {name: profile_name, location: profile_location, profile_url: profile_link}
      end
    end
    profiles
  end


  def self.scrape_profile_page(profile_url)
    student = {}

    profile_page = Nokogiri::HTML(open(profile_url))

    links = profile_page.css("div.social-icon-container a").collect{ |social_sites| social_sites.attribute('href').value }
    links.each do |link|
      if link.include? "twitter"
        student[:twitter] = link
      elsif link.include? "linkedin"
        student[:linkedin] = link
      elsif link.include? "github"
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css(".bio-content.content-holder .description-holder p").text
    student

  end
end
