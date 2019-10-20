require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student.css('a').each do |a| 
          student_url = student.attr('href')
      array << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    end
    array
  end
  
  #attr is used to get ATTRIBUTES off of the html element
              #when you're working with an object that represents a single html element like that, you can drill into its html attributes with that method

  def self.scrape_profile_page(profile_url)
    hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    link = doc.css(".social-icon-container").css("a").attr('href')
      link.each do |link|
        if link.include?("linkedin")
          student[:linkedin] = link
        elsif   
        end
      end
    end

    
    
    #scraping individual student profile page to get further info
    #return value is hash of key/value pairs describing a student
    #scrapes twitter, linkedin, github, blog, profile quote, bio--also allows for when these aren't provided
    


