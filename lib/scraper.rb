require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)

    students = []

    index_page.css("div.student-card").each do |student|
      hash = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value,
      }
      students << hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    # binding.pry

    student_attribute = {}

    profile_page.css("div.social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_attribute[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_attribute[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_attribute[:github] = social.attribute("href").value
      else
        student_attribute[:blog] = social.attribute("href").value
      end
    end

    student_attribute[:profile_quote] = profile_page.css("div.profile-quote").text
    student_attribute[:bio] = profile_page.css("div.description-holder p").text

    student_attribute
  end

end

# roster_container : index_page.css("div.student-card")
# name : roster_container.css("h4.student-name").text
# location : roster_container.css("p.student-location").text
# profile_url : index_page.css("div.student-card").first.css("a").attribute("href").value

# social_container = profile_page.css("div.social-icon-container a")
