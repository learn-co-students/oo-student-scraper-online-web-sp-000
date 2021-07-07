
require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    array_of_student_hashes = []
    self.get_students(index_url).each do |student_card|
      #student = Student.new
      name = student_card.css("h4.student-name").text
      location = student_card.css("p.student-location").text
      profile_url = student_card.css("a")[0]["href"]

      student_hash = {:name => name, :location => location, :profile_url => profile_url}
      array_of_student_hashes << student_hash
      #puts profile_url
    end
    array_of_student_hashes
  end


  def self.scrape_profile_page(html)
    profile_hash = Hash.new()
    doc = self.get_page(html)
    doc.css(".social-icon-container").css("a").each do |a_item|
      item = a_item["href"]
      if item.include?("twitter")
        profile_hash[:twitter] = item
      elsif item.include?("linkedin")
        profile_hash[:linkedin] = item
      elsif item.include?("github")
        profile_hash[:github] = item
      else
        profile_hash[:blog] = item
      end
    end
    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css("p").text
    profile_hash
  end

  def self.get_students(html)
    self.get_page(html).css(".student-card")
  end

  def self.get_page(html)
    doc = Nokogiri::HTML(URI.open(html))
  end
end

#Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/")
Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html")
