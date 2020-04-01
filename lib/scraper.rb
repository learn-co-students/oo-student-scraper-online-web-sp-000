require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
        page = index_page.css(".student-card a").each do |student|
            student_name = student.css('.student-name').text
            student_location = student.css('.student-location').text
            student_profile_link = student.attribute("href").value
            student_hash = {name: student_name, location: student_location, profile_url: student_profile_link}
            students << student_hash
          #  binding.pry
          end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container a").map { |e| e.attribute('href').value}
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
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    student
  end
end







#twitter
#github
#profile_quote
#bio
#linkedin
