require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []

    doc.css("div.student-card").each do |student|
      scraped_hash = {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
      scraped_students << scraped_hash
    end
    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}
    links = doc.css("div.social-icon-container a").map {|link| link["href"]}

    links.each do |link|
      hash[:twitter] = link if link.include?("twitter")
      hash[:linkedin] = link if link.include?("linkedin")
      hash[:github] = link if link.include?("github")
      hash[:blog] = link if !link.include?("github") && !link.include?("linkedin") && !link.include?("twitter")
    end
    hash[:profile_quote] = doc.css(".profile-quote").text
    hash[:bio] = doc.css("p").text
    hash
  end

end
