require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url)).css("div.student-card")
    data = []
    doc.each do |element|
      name = element.css("h4.student-name").text
      location = element.css("p.student-location").text
      profile_url = element.css("a").attribute("href").value
      new_hash = {
        :location => location,
        :name => name,
        :profile_url => profile_url
      }
      data << new_hash
    end
    data
  end

  def self.scrape_profile_page(profile_url)
    new_hash = {}
    doc = Nokogiri::HTML(open(profile_url)).css("div.main-wrapper.profile")
    urls =  doc.css("div.social-icon-container a")
    urls.each do |url|
      link=url.attribute("href").value
      if link.include?("twitter.com")
        new_hash[:twitter] = link
      elsif link.include?("linkedin.com")
        new_hash[:linkedin] = link
      elsif link.include?("github.com")
        new_hash[:github] = link
      else
        new_hash[:blog] = link
      end
    end
    new_hash[:profile_quote] = doc.css("div.profile-quote").text
    new_hash[:bio] = doc.css("div.description-holder p").text
    new_hash
  end

end
