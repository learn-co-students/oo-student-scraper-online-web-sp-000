require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    information = Nokogiri::HTML(open(index_url))
    data = information.css(".student-card")

    data.map {|field|
      {:name => field.css("h4").text, 
      :location => field.css("p").text, 
      :profile_url => field.css("a")[0]["href"]} 
      }
  end

  def self.scrape_profile_page(profile_url)
    data_hash = {}
    information = Nokogiri::HTML(open(profile_url))
    social_data = information.css(".social-icon-container")[0].css("a")
    links_array = social_data.collect {|field| field["href"]}
    
    links_array.each {|link|
        if link.include?("linkedin")
          data_hash[:linkedin] = link
        elsif link.include?("twitter")
          data_hash[:twitter] = link
        elsif link.include?("github")
          data_hash[:github] = link
        else 
          data_hash[:blog] = link
        end
    }
        data_hash[:profile_quote] = information.css(".profile-quote").text
        data_hash[:bio] = information.css(".description-holder")[0].text.strip
        data_hash
  end

end
