require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      doc = Nokogiri::HTML(open(index_url))
      students = doc.css(".student-card")

      students.collect do |student|
        {
          name: student.css(".student-name").text,
          location: student.css(".student-location").text,
          profile_url: student.css("a").attr("href").value
        }
      end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}

    doc.css(".social-icon-container a").each do |social|
        if social.attr("href").include? "twitter"
          profile_hash[:twitter] = social.attr("href")
        elsif social.attr("href").include? "linkedin"
          profile_hash[:linkedin] = social.attr("href")
        elsif social.attr("href").include? "github"
          profile_hash[:github] = social.attr("href")
        else
          profile_hash[:blog] = social.attr("href")
        end
    end

    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".description-holder p").text

    profile_hash
  end

end
