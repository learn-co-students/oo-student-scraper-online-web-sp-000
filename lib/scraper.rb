require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    #index =  ./fixtures/student-site/index.html
    students = []
    html = open(index_url)
    index = Nokogiri::HTML(html)
    index.css("div.student-card").each do |student|
      details = {}
      details[:name] = student.css("h4.student-name").text
      details[:location] = student.css("p.student-location").text
      details[:profile_url] = student.css("a").attribute("href").value
      students << details
    end
    #binding.pry
    return students
  end

  def self.scrape_profile_page(profile_url)
    details = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        details[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        details[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        details[:github] = social.attribute("href").value
      else
        details[:blog] = social.attribute("href").value
      end
    end
    details[:profile_quote] = profile.css(".profile-quote").text
    details[:bio] = profile.css(".bio-content .description-holder p").text
    return details
  end
end
