require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    students.collect do |student|
      {
        name: student.css('.student-name').text,
        location: student.css('.student-location').text,
        profile_url: student.css('a').first['href']
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_links = doc.css('.social-icon-container a')
    
    Hash.new.tap do |hash|
      social_links.inject(hash) do |social_hash, link|
        key = link.css('.social-icon').first['src'].slice(/.*\/(.*)-/, 1)
        key = 'blog' if key == 'rss'
        social_hash[key.to_sym] = link['href']
        social_hash  
      end
      hash[:profile_quote] = doc.css('.profile-quote').text
      hash[:bio] = doc.css('.bio-block p').text
    end
  end
end

