require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    index_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"
    scraped_students = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css("div.roster-cards-container").each do |profile|
      profile.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        profile_url
    # :name =
    # :location =
    # :profile_url =
    # binding.pry


  end

  def self.scrape_profile_page(profile_url)

  end

end
