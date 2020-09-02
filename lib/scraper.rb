require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = []
    html = open(index_url)
    info = Nokogiri::HTML(html)

    info.css("div.student-card").each do |student|
      profile = {}
      profile[:name] = student.css("h4.student-name").text
      profile[:location] = student.css("p.student-location").text
      profile[:profile_url] = student.css("a").attribute("href").value
      profiles << profile
    end
    
    profiles
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    html = open(profile_url)
    info = Nokogiri::HTML(html)

    profile[:profile_quote] = info.css("div.profile-quote").text
    profile[:bio] = info.css("div.details-container div.description-holder p").text
    
    info.css("div.social-icon-container a").each do |icon|
      if icon.attribute("href").value.include?("twitter")
        profile[:twitter] = icon.attribute("href").value
      elsif icon.attribute("href").value.include?("linkedin")
        profile[:linkedin] = icon.attribute("href").value
      elsif icon.attribute("href").value.include?("github")
        profile[:github] = icon.attribute("href").value
      else icon.attribute("href").value.include?("blog")
        profile[:blog] = icon.attribute("href").value
      end

    end

    profile
  end
end

# Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html")