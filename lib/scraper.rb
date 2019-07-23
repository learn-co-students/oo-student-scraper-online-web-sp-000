require 'open-uri'
require 'pry'

#In this lab, you'll be scraping your Learn.co student website. You'll use the index page to grab a list of
#current students and instantiate a series of Student objects. You'll scrape the individual profile pages of each
#student to add attributes to each individual student.

class Scraper
  #is a class method that scrapes the student index page ('./fixtures/student-site/index.html')
  #and a returns an array of hashes in which each hash represents one student
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|     #parse through each container
      card.css(".student-card a").each do |student|                 #parse through each student in card
        name = student.css('.student-name').text                      #grab name
        location = student.css('.student-location').text              #grab location
        profile_link = "#{student.attr('href')}"                      #grab link
        students << {name: name, location: location, profile_url: profile_link}
      end
    end
    return students

  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    link = profile_page.css(".social-icon-container").children.css("a").map do |element|
      element.attribute('href').value
    end

  end
end
