require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  # responsible for scraping the index page that lists all of the students
  # The return value of this method should be an array of hashes in which
  # each hash represents a single student.
  # The keys of the individual student hashes should be :name, :location and :profile_url
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    all_students = []

    doc.css("div.student-card").each do |student_info|
      name = student_info.css(".student-name").text
      location = student_info.css(".student-location").text
      profile_url = student_info.css("a").attribute("href").value

        student_hash = {
          :name => name,
          :location => location,
          :profile_url => profile_url
        }

        all_students << student_hash
      end
      all_students
    end


  # responsible for scraping an individual student's profile page to get further information about that student.
  # This is a class method that should take in an argument of a student's profile URL.
  # It should use Nokogiri and Open-URI to access that page.
  # The return value of this method should be a hash in which the key/value pairs describe an individual student.
  # Some students don't have a Twitter or some other social link. Be sure to be able to handle that.

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    indi_student = {}

    # iterate through social links and add to hash
    social = doc.css(".social-icon-container a").collect {|att| att.attribute("href").value}
      social.each do |social_link|
        if social_link.include?("twitter")
          indi_student[:twitter] = social_link
        elsif social_link.include?("linkedin")
          indi_student[:linkedin] = social_link
        elsif social_link.include?("github")
          indi_student[:github] = social_link
        elsif social_link.include?(".com")
          indi_student[:blog] = social_link
        end
      end

      # after loop, add name, bio and quote to hash
      indi_student[:profile_quote] = doc.css(".profile-quote").text
      indi_student[:bio] = doc.css(".details-container p").text

    # return hash 
    indi_student
  end

end
