require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |row|
      students << {
      :name => row.css(".student-name").text,
      :location => row.css(".student-location").text,
      :profile_url => row.css("a").attribute("href").value
      }
    end
    return students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}
    doc.css(".social-icon-container a").each do |link|
      href = link.attribute('href').value
      if href.include?("twitter")
       profile[:twitter] = href
      elsif href.include?("linkedin")
       profile[:linkedin] = href
      elsif href.include?("github")
        profile[:github] = href
      else
        profile[:blog] = href
      end
    end
    profile[:bio] = doc.css("p").text
    profile[:profile_quote] = doc.css(".profile-quote").text
    return profile
  end
end
