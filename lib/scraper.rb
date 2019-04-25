require 'open-uri'
require 'nokogiri'
require 'pry'

require_relative "../lib/student.rb"

class Scraper
  attr_accessor :name, :location, :profile_url


  def self.scrape_index_page(index_url)
   index_page = Nokogiri::HTML(open(index_url))
   students = []
   index_page.css("div.roster-cards-container").each do |card|
     card.css(".student-card a").each do |student|


       name = student.css('.student-name').text
       location = student.css('.student-location').text
       profile_url = "#{student.attr('href')}"
       students << {name: name, location: location, profile_url: profile_url}
     end
   end
   students
 end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))

      links = profile.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
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
      # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
      # # if profile_page.css(".social-icon-container").children.css("a")[0]
      # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
      # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
      # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
      student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
      student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p")

      student
    end

  end
