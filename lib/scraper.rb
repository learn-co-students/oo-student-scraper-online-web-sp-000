require 'open-uri'
require 'pry'

#Twitter, linkedin, github, blog, profile_quote, and bio
class Scraper

#Responsible for scraping the index page that lists all of the students

#Takes in URL as argument
#Uses Nokogiri + Open-URI to access page
#Return value should be an array of hashes - ea hash represents a single student
#keys should be :name, :location and :profile_url
  def self.scrape_index_page(index_url)
    students = []
    html = open (index_url)
    index = Nokogiri::HTML(html)
    index.css("div.student-card"). each do |student|
      student_details = {}
      student_details[:name] = student.css("h4.student-name").text
      student_details[:location] = student.css("p.student-location").text
      profile_path = student.css("a").attribute("href").value
      profile_path.slice!(".fixtures/student-site/")
      student_details[:profile_url] = profile_path
      students << student_details
    end
      students
  end

#Responsible for scraping an indiviual student's profile page to get student info
#Takes in a student's profile URL
#Uses Nokogiri + Open-URI to access page
#Return value should be a hash with key/value pairs that describe an indivual student
#Some students have twitter while others don't
  def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open (profile_url)
    profile = Nokogiri::HTML(html)
# binding.pry
    #social
    profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    end
    student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text
    student_profile
  end

end

#index.css(".student-text-card").first
#index.css("h4.student-name").first.text
#index.css("p.student-location").first.text
#index.css("a").attribute("href").value
#'.fixtures/student-site/'

#Social container: profile.css(".social-icon-container").first
#Profile quote: profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
#Bio: profile.css("div.main-wrapper.profile .description-holder p").text
