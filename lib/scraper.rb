require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |post|
      name = post.css(".student-name").text
      location = post.css(".student-location").text
      profile_url = post.css("a").attribute("href").value
      info = {:name => name,
        :location => location,
        :profile_url => profile_url
      }
      students << info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    page = doc.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
    page.each do |link|
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
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
    student
  end

end
