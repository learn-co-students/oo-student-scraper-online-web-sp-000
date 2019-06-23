require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    site = Nokogiri::HTML(open(index_url))
    site.css(".student-card").each do |card|
      student = {name: card.css(".student-name").text, location: card.css(".student-location").text, profile_url: card.css("a").attribute("href").value}
      Student.all << student
    end
    Student.all
  end

  def self.scrape_profile_page(profile_url)
    @student_links = {}
    sub_site = Nokogiri::HTML(open(profile_url))
    sub_site.css(".social-icon-container a").each do |link|
      anchor = link.attribute("href").value

      if anchor.scan(/twitter/)[0]
        @student_links[:twitter] = anchor
      elsif anchor.scan(/linkedin/)[0]
        @student_links[:linkedin] = anchor
      elsif anchor.scan(/github/)[0]
        @student_links[:github] = anchor
      else
        @student_links[:blog] = anchor
      end
    end
    @student_links[:profile_quote] = sub_site.css(".profile-quote").text
    @student_links[:bio] = sub_site.css(".description-holder p").text
    @student_links
  end
end
