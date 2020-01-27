require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  # def get_page
  #   Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
  # end

  # responsible for scraping the index page that lists all of the students
  # The return value of this method should be an array of hashes in which
  # each hash represents a single student.
  # The keys of the individual student hashes should be :name, :location and :profile_url
  def self.scrape_index_page(index_url)
    # binding.pry
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    all_students = doc.css(".student-card")
      # puts all_students
    # single_student = get_page.css(".student-card").first
      # puts single_student
    first_name = doc.css(".student-card").first.css("h4").text
    location = doc.css(".student-card").first.css("p").text
    # i'm close here, but not quite pulling out the url
    profile_url = doc.css(".student-card").first.css("ahref").text
    puts first_name
    puts location
    puts profile_url

    # iterate through each

    # student_hash = {
    #   :name => first_name
    #   :location =>
    #   # :profile_url =>
    # }
    # puts student_hash
  end

  # responsible for scraping an individual student's profile page to get further information about that student.
  # This is a class method that should take in an argument of a student's profile URL.
  # It should use Nokogiri and Open-URI to access that page.
  # The return value of this method should be a hash in which the key/value pairs describe an individual student.
  # Some students don't have a Twitter or some other social link. Be sure to be able to handle that.

  # def self.scrape_profile_page(profile_url)
  #
  # end

end
