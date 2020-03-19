require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_node_array = doc.css(".student-card")
    student_dictionary_array = []
    student_node_array.each do |student_node|
      student_dictionary = {
        name: student_node.css(".student-name").text,
        location: student_node.css(".student-location").text,
        profile_url: student_node.css("a").first["href"]
      }
      student_dictionary_array << student_dictionary
    end
    student_dictionary_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_networking = doc.css(".social-icon-container a")
    student_dict = {
      profile_quote: doc.css(".profile-quote").text,
      bio: doc.css(".description-holder p").text
    }
    social_networking.each do |anchor|
      if anchor["href"].include?("twitter")
        student_dict[:twitter] = anchor["href"]
      elsif anchor["href"].include?("linkedin")
        student_dict[:linkedin] = anchor["href"]
      elsif anchor["href"].include?("github")
        student_dict[:github] = anchor["href"]
      elsif !anchor["href"].include?("https")
        student_dict[:blog] = anchor["href"]
      end
    end
    student_dict
  end

end
