require 'open-uri'
require 'pry'

#In this lab, you'll be scraping your Learn.co student website. You'll use the index page to grab a list of
#current students and instantiate a series of Student objects. You'll scrape the individual profile pages of each
#student to add attributes to each individual student.

class Scraper
  #is a class method that scrapes the student index page ('./fixtures/student-site/index.html')
  #and a returns an array of hashes in which each hash represents one student
  def self.scrape_index_page(index_url)

    page = Nokogiri::HTML(index_html)
    students = []
    page = css.()
    
  end

  def self.scrape_profile_page(profile_url)

  end

end
