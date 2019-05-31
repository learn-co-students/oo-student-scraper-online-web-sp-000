require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url)).css(".student-card")
    page.collect do |profile|
      {
        name: profile.css("h4").text,
        location: profile.css("p").text,
        profile_url: profile.css("a").first.attribute('href').value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    profile = {
      profile_quote: page.css(".profile-quote").text,
      bio: page.css("p").text
    }
    social = page.css(".social-icon-container").css("a").collect { |social| social.attribute('href').value }
    social.each do |social_link|
      if social_link.include?("twitter")
        profile[:twitter] = social_link
      elsif social_link.include?("linkedin")
        profile[:linkedin] = social_link
      elsif social_link.include?("github")
        profile[:github] = social_link
      else
        profile[:blog] = social_link
      end
    end
    profile
  end

end