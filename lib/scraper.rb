require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    students = []
    doc = Nokogiri::HTML(html)
    doc.css(".student-card a").each do |student|
      student = {
      :name => student.css(".student-name").text,
      :location => student.css(".student-location").text,
      :profile_url => student.attribute("href").value
    }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}

    profile_links = profile.css(".social-icon-container").children.css("a").map { |content| content.attribute('href').value}
    profile_links.each do |link|

      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif
        student[:blog] = link
      end

    student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    student[:bio] = profile.css("p").text

    end
    student
  end

end
