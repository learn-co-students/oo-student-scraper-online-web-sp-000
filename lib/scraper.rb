require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url) # scraping the index page that lists all of the students
    students = [] # creating an array to store students
    
    doc = Nokogiri::HTML(open(index_url)) # creating local variable and setting it equal to the url's HTML that we retrieve using nokogiri

    doc.css(".student-card").collect do |student| # using nokogiri css selector and passing in class id to iterate over students and assign key:, value pairs for the students attributes
      hash = {
        name: student.css("h4.student-name").text, profile_url: student.css("a").attribute("href").value, location: student.css("p.student-location").text
      }
      students << hash
    end
    students
  end

  def self.scrape_profile_page(profile_url) # scraping an individual student's profile page to get further info about the student
    doc = Nokogiri::HTML(open(profile_url))

      student_profiles = {}
     
      social_link = doc.css(".vitals-container .social-icon-container a")
      
      social_link.each do |element|
        if element.attr("href").include?("twitter")
          student_profiles[:twitter] = element.attr('href')
        elsif element.attr("href").include?("linkedin")
          student_profiles[:linkedin] = element.attr("href")
        elsif element.attr("href").include?("github")
          student_profiles[:github] = element.attr("href")
        elsif element.attr("href").include?("com/")
        student_profiles[:blog] = element.attr("href")
        end
      end
      
      student_profiles[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      student_profiles[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text
      
      student_profiles
  end
end

