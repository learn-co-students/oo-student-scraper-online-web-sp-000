require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |student|
      name = student.css("h4").text
      location = student.css("p").text
      profile_url = student.css("a").attribute("href").value
      students << {name: name, location: location, profile_url: profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile_page.css("div.profile-quote").text if profile_page.css("div.profile-quote")
    student[:bio] = profile_page.css("div.description-holder p").text if profile_page.css("div.description-holder p").text
    student
end

end

#Scraper.scrape_profile_page("fixtures/student-site/students/ryan-johnson.html")

#profile_page.css("div.social-icon-container a").attribute("href").value if profile_page.css("div.social-icon-container a").attribute("href").value.include?("linkedin")