require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  # responsible for scraping the index page that lists all of the students
  # return hashes- :name, :location and :profile_url
  def self.scrape_index_page(index_url)

    index_url = open('https://learn-co-curriculum.github.io/student-scraper-test-page/index.html')

    student_list = Nokogiri::HTML(index_url)
    #binding.pry
    # array to store data scraped from website
    student_info = []
    
    # scraping name, location, & profile url
    student_list.css("div.student-card").each do |student|
      info = {}
      info[:name] = student.css("h4.student-name").text
      info[:location] = student.css("p.student-location").text
      info[:profile_url] = student.css("a").attribute("href").value
      
      # pushing hash into student_info array
      student_info << info
    end
    student_info
  end
 
  # responsible for scraping an individual student's profile page to get further information about that student
  def self.scrape_profile_page(profile_url)
    
    index_url = open(profile_url)
    profile_page = Nokogiri::HTML(index_url)
   
    #binding.pry
    profile_info = {}
    # scraping profile for twitter, linkedin, github, blog from "social-icon-container"
    profile_page.css("div.social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        profile_info[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        profile_info[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        profile_info[:github] = social.attribute("href").value
      else
        profile_info[:blog] = social.attribute("href").value
      end
    end

      profile_info[:profile_quote] = profile_page.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
      profile_info[:bio] = profile_page.css("div.main-wrapper.profile .description-holder p").text

    profile_info
  end
  
end

