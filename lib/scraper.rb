require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_hash_array = []
    doc.css("div.student-card").collect do |student|
      student_hash = {
        :name => student.css("h4.student-name").text,
        :location =>  student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").text
      }
      student_hash_array << student_hash
    end
    student_hash_array
  end

  def self.scrape_profile_page(profile_url)

    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student_profile_hash = {}

    doc.css("div.social-icon-container a").each do |media|
      href = media.attribute("href").text
      student_profile_hash[:linkedin] = href if href.include?("linkedin")
      student_profile_hash[:twitter] = href if href.include?("twitter")
      student_profile_hash[:github] = href if href.include?("github")

      student_profile_hash[:blog] = href if !href.include?("linkedin") && !href.include?("twitter") && !href.include?("github")
    end

    student_profile_hash[:profile_quote] = doc.css("div.profile-quote").text
    student_profile_hash[:bio] = doc.css("div.bio-content p").text
    # binding.pry
    student_profile_hash

  end

end
