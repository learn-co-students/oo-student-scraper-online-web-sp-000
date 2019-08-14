require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".student-card").each do |node| 
      student_hash = Hash.new 
      student_hash[:name] = node.css(".student-name").text
      student_hash[:location] = node.css(".student-location").text
      student_hash[:profile_url] = node.css("a").attribute("href").value
      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_profile_hash = Hash.new 
    doc.css("div.social-icon-container a").each do |node|
      link = node.attribute("href").value
        if link.include?("twitter")
          student_profile_hash[:twitter] = link
        elsif link.include?("linkedin")
          student_profile_hash[:linkedin] = link
        elsif link.include?("github")
          student_profile_hash[:github] = link
        else
          student_profile_hash[:blog] = link
        end
      student_profile_hash
    end
    doc.css(".bio-content.content-holder").each do |node|
      student_profile_hash[:bio] = node.css("p")[0].text
    end
    doc.css(".vitals-text-container").each do |node|
      student_profile_hash[:profile_quote] = node.css(".profile-quote").text.strip
    end
    
    student_profile_hash
  end

end

