require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    profiles = []
    
    Nokogiri::HTML(open(index_url)).css(".student-card").collect do |s| 
        profiles << hash = {
          name: s.css('.student-name').text, 
          location: s.css('.student-location').text,
          profile_url: s.children.css("a")[0].attributes["href"].value
        } 
    end
      profiles   
  end

  def self.scrape_profile_page(profile_url)
    profile_hash =  {}
    html =  Nokogiri::HTML(open(profile_url))
    html.css(".social-icon-container a").each do |o|
      link = o.attributes['href'].value
      if link.include?('twitter')
        profile_hash[:twitter] = link
      elsif link.include?('linkedin')
        profile_hash[:linkedin] = link
      elsif link.include?('github')
        profile_hash[:github] = link
      else
        profile_hash[:blog] = link
      end
    end
    profile_hash[:profile_quote] = html.css(".vitals-container div.profile-quote").text
    profile_hash[:bio] = html.css(".description-holder p").text
    # binding.pry
    profile_hash
  end
end

# profile = 'https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html'
# path = Nokogiri::HTML(open(profile))
# puts path