require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect do |student|
      new_student = {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css('a')[0]["href"]
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    # scrape an individual student's profile page to get further information about that student
    doc = Nokogiri::HTML(open(profile_url))
    profile_quote_text = doc.css(".profile-quote").text
    bio_content = doc.css(".bio-content").first.css('p').text
    link_array = doc.css(".social-icon-container").first.css('a').collect do |social_media_icon|
      social_media_icon["href"]
    end
    social_media_object = {}

    link_array.each do |link|
      if link.match(/twitter/)
        social_media_object[:twitter] = link
      elsif link.match(/linkedin/)
        social_media_object[:linkedin] = link
      elsif link.match(/github/)
        social_media_object[:github] = link
      else
        social_media_object[:blog] = link
      end
    end
    social_media_object[:profile_quote] = profile_quote_text
    social_media_object[:bio] = bio_content
    social_media_object
  end
end
