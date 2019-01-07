require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    #for the student name = doc.css(".student-name").text
    #location = doc.css(".student-location").text
    #website = student.css("a").attribute("href").value

    html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    doc.css(".student-card").map do |students|
      {
        name: students.css("h4.student-name").text,
        location: students.css("p.student-location").text,
        profile_url: students.css("a").attribute("href").value
      }
    end
  end


  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    student = {}

    links = profile.css(".social-icon-container a").map do |link|
      link.attribute("href").value
    end

    links.each do |link|
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

    student[:profile_quote] = profile.css(".profile-quote").text
    student[:bio] = profile.css(".description-holder p").text
    student
  end
end
