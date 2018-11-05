require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect do |student|
      student_hash = {
      name: student.css("h4.student-name").text,
      location: student.css("p.student-location").text,
      profile_url: student.css("a").attr("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {
      bio: doc.css(".description-holder p").text,
      profile_quote: doc.css(".profile-quote").text
    }

    links = doc.css(".social-icon-container a").collect { |t| t.attribute("href").value }

    links.each do |link|
      if link.include?("github")
        profile_hash[:github] = link
        elsif link.include?("twitter")
        profile_hash[:twitter] = link
        elsif link.include?("linkedin")
        profile_hash[:linkedin] = link
      else
        profile_hash[:blog] = link
      end
    end
    profile_hash
  end
end
