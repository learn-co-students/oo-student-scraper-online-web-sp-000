require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []

    doc.css(".student-card").each do |info|
      student_hash = {
        name: info.css(".student-name").text,
        location: info.css(".student-location").text,
        profile_url: info.css("a").attribute("href").value
      }
      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}
  #  binding.pry
    doc.css("div.main-wrapper.profile .social-icon-container a").each do |info|
      if info.attribute("href").value.include?("twitter")
        hash[:twitter] = info.attribute("href").value
      elsif info.attribute("href").value.include?("linkedin")
        hash[:linkedin] = info.attribute("href").value
      elsif info.attribute("href").value.include?("github")
        hash[:github] = info.attribute("href").value
      else
        hash[:blog] = info.attribute("href").value
      end
    end
    hash[:profile_quote] = doc.css("div.profile-quote").text
    hash[:bio] = doc.css("div.main-wrapper.profile .description-holder p").text

    hash
  end

end
