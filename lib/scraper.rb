require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |s|
      name = s.css(".student-name").text
      location = s.css(".student-location").text
      profile_url = s.css("a").attribute("href").value
      student_obj = {:name => name, :location => location, :profile_url => profile_url}
      students << student_obj
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = open(profile_url)
    doc = Nokogiri::HTML(profile)
    profile_details = {}

    links = doc.css(".vitals-container .social-icon-container a")
    links.each do |l|
      if l.attr("href").include?("twitter")
        profile_details[:twitter] = l.attr("href")
      elsif l.attr("href").include?("linkedin")
        profile_details[:linkedin] = l.attr("href")
      elsif l.attr("href").include?("github")
        profile_details[:github] = l.attr("href")
      elsif l.attr("href").end_with?("com/")
        profile_details[:blog] = l.attr("href")
      end
    end
    profile_details[:profile_quote] = doc.css(".vitals-container .vitals-text-container div").text
    profile_details[:bio] = doc.css(".details-container .bio-block.details-block .bio-content.content-holder .description-holder p").text.strip
    profile_details
  end


end
