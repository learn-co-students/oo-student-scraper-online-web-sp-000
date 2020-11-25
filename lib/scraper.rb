require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url))
    student_array = []
    students.css(".student-card").each do |s|
      this_hash = Hash.new(0)
      this_hash[:location] = s.css("p").text
      this_hash[:name] = s.css("h4").text
      this_hash[:profile_url] = s.css("a").first["href"]
      student_array << this_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student_details = Hash.new(0)
    hrefs = profile.css(".social-icon-container a").map {|anchor| anchor["href"] }
    hrefs.each do |url|
      if url.include? "twitter"
        student_details[:twitter] = url
      elsif url.include? "linkedin"
        student_details[:linkedin] = url
      elsif url.include? "github"
        student_details[:github] = url
      else
        student_details[:blog] = url
      end
    end
    student_details[:profile_quote] = profile.css(".profile-quote").text
    student_details[:bio] = profile.css("div p").text
    student_details
  end
end
