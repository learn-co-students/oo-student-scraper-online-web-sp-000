require 'nokogiri'

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    array = []

    page = Nokogiri::HTML(open(index_url))

    page.css(".student-card").each do |student|
      details = {}
      details[:name] = student.css(".student-name").text
      details[:location] = student.css(".student-location").text
      details[:profile_url] = student.css("a")[0].attributes["href"].value
      array << details
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    html = open(profile_url)
    student_profile = Nokogiri::HTML(html)

    student_profile.css(".social-icon-container").each do |social_media|
      if social_media.attribute["href"].value.include?("twitter")
        profile_hash[:twitter] = social_media.children[1].attributes["href"].value
      elsif social_media.attribute["href"].value.include?("linkedin")
        profile_hash[:linkedin] = social_media.children[1].attributes["href"].value
      elsif social_media.attribute["href"].value.include?("github")
        profile_hash[:github] = social_media.children[1].attributes["href"].value
      else social_media.attribute["href"].value.include?("blog")
        profile_hash[:blog] = social_media.children[1].attributes["href"].value
      end
    end
    profile_hash[:profile_quote] = student_profile.css(".profile-quote").text
    profile_hash[:bio] = student_profile.css(".description-holder").text

    profile_hash
  end
end
