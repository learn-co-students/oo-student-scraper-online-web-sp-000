require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    learn_page = Nokogiri::HTML(open(index_url))
    students = []
    learn_page.css(".student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      new_student = {
        :name => name,
        :location => location,
        :profile_url => profile_url
      }
      students << new_student
    end
    students
  end



  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    social_container = profile_page.css(".social-icon-container a").map{|icon| icon.attribute("href").value}
      social_container.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
        end
      end
      student[:profile_quote] = profile_page.css(".profile-quote").text
      student[:bio] = profile_page.css(".description-holder p").text
      student
  end

end
