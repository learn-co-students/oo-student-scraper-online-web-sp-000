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
      scraped_profile[:twitter] = social_site.css('a/@href').first.text
      scraped_profile[:linkedin] = social_site.css('a/@href')[1].text
      scraped_profile[:github] = social_site.css('a/@href')[2].text
      scraped_profile[:blog] = social_site.css('a/@href')[3].text
    end
    scraped_profile[:profile_quote] = profile_page.css('.profile-quote').text
    scraped_profile
  end

end
