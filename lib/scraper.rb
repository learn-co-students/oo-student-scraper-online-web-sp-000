require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    page = Nokogiri::HTML(open(index_url))
      page.css(".student-card").each do |student_info|
        name = student_info.css("h4").text
        location = student_info.css(".student-location").text
        profile_url = student_info.css("a")[0]['href']      
    student_array << {name: name, location: location, profile_url: profile_url}
    end 
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    student_page = Nokogiri::HTML(open(profile_url))
    social_links = student_page.css("social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    social_links.each do |social_link|
      if social_link.include?("twitter")
        student[:twitter] = link
      elsif social_link.include?("linkedin")
        student[:linkedin] = link
      elsif social_link.include?("github")
        student[:github] = link
      elsif social_link.include?("youtube")
        student[:youtube] = link
      else
        student[:blog] = link
      end 
      student[:profile_quote] = student_page.css(".profile-quote").text if student_page.css(".profile-quote")
      student[:bio] = student_page.css("div.bio-content.content-holder div.description-holder p").text if student_page.css("div.bio-content.content-holder div.description-holder p")
    end 
    student

  end

end

