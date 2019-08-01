require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students = []

    all_student_cards = doc.css("div.student-card")

    all_student_cards.each do |card|
      student = {
        name: card.css("h4").text,
        location: card.css("p.student-location").text,
        profile_url: card.css("a").attribute("href").value,
      }
      students << student
    end

    students
  
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student_hash = {}

    links = doc.css("div.social-icon-container a")

    links.each do |link|
      url_value = link.attribute("href").value
      if url_value.include?("twitter")
        student_hash[:twitter] = url_value
      elsif url_value.include?("github")
        student_hash[:github] = url_value
      elsif url_value.include?("linkedin")
        student_hash[:linkedin] = url_value
      else
        student_hash[:blog] = url_value
      end  
    end

    student_hash[:profile_quote] = doc.css("div.profile-quote").text
    student_hash[:bio] = doc.css("div.bio-content p").text

    student_hash
  end

end

