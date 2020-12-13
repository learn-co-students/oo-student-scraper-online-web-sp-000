require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    index_array = Array.new
    
    doc.css(".student-card").each_with_index do |card, index|
      new_hash = {  
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.xpath('//div/a/@href')[index].text
      }
      index_array << new_hash
    end
    index_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = Hash.new

    doc.css("div.social-icon-container a @href").each do |icon| 
      case
      when icon.value.include?("twitter")
        profile_hash.merge!(:twitter => "#{icon}")
      when icon.value.include?("linkedin")
        profile_hash.merge!(:linkedin => "#{icon}")
      when icon.value.include?("github")
        profile_hash.merge!(:github => "#{icon}")
      else
        profile_hash.merge!(:blog => "#{icon}")
      end
    end
    profile_hash.merge!(:profile_quote => doc.css("div.vitals-text-container div.profile-quote").text)
    profile_hash.merge!(:bio => doc.css("div.description-holder p").text)
  end
end
