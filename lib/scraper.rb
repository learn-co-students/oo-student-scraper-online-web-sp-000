require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    inpex_page = Nokogiri::HTML(open(index_url))
    scraped_array = []
    inpex_page.css('.student-card').each do |roster_card|
      scraped_hash = {}
      scraped_hash[:name] = roster_card.css('.student-name').text
      scraped_hash[:location] = roster_card.css('.student-location').text
      scraped_hash[:profile_url] = roster_card.css('a/@href').text
      scraped_array << scraped_hash
    end
    scraped_array
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    scraped_profile = {}
    profile_page.css('.social-icon-container').each do |social_site|
      social_sites_array = social_site.css('a/@href').text.split('http')
      social_sites_array.each do |site|
        if site.include?("twitter")
          scraped_profile[:twitter] = "http" + site
        elsif site.include?("linkedin")
          scraped_profile[:linkedin] = "http" + site
        elsif site.include?("github")
          scraped_profile[:github] = "http" + site
        else
          scraped_profile[:blog] = "http" + site
        end
      end
    end
    scraped_profile.delete_if {|k, v| v == "http"}
    scraped_profile[:profile_quote] = profile_page.css('.profile-quote').text
    scraped_profile[:bio] = profile_page.css('.description-holder/p').text
    scraped_profile
  end

end
