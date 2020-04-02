require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  # "https://learn-co-curriculum.github.io/student-scraper-test-page/index"
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    cards = doc.css(".student-card")

    index_array = []

    cards.each do |c|
      index_array <<
      {name: c.children[1].children[3].children[1].text,
      location: c.children[1].children[3].children[3].text,
      profile_url: c.children[1].attributes["href"].value}
    end

    index_array
  end

    # "https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"
    # "students/ryan-johnson.html"
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social = doc.css(".social-icon-container a")

    # searches through social icon container and returns array of all social urls
    all_social_urls = social.collect { |o| o.attributes["href"].value }

    profile_hash = {}

    # searches through array of social urls and assigns to correct variable
    all_social_urls.each do |u|
      if u.include?("twitter")
        profile_hash[:twitter] = u
      elsif u.include?("linkedin")
        profile_hash[:linkedin] = u
      elsif u.include?("github")
        profile_hash[:github] = u
      else
        profile_hash[:blog] = u
      end
    end
    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".description-holder p").text
    profile_hash
  end
end
