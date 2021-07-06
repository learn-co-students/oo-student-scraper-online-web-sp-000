require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    roster_of_students = page.css(".roster-cards-container .student-card")
    student_info = []
    roster_of_students.each do |student|
      student_hash = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      student_info << student_hash
    end
    student_info
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    social_container = profile_page.css(".social-icon-container a")
    profile = {}
    social_container.each do |social|
      if social.attribute("href").value.include?("twitter.com")
        profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github.com")
        profile[:github] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin.com")
        profile[:linkedin] = social.attribute("href").value
      else
        profile[:blog] = social .attribute("href").value
      end
    end
    profile[:profile_quote] = profile_page.css(".profile-quote").text
    profile[:bio] = profile_page.css(".bio-content.content-holder p").text
    profile
  end
end
