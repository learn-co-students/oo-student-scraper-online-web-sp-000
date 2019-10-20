require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #scrapes index that lists all students
    #uses nokogiri and open uri to access page
    #return value should be array of hashes 
    #each hash represents a signle student
    #keys are :name :location :profile_url
    #takes a lot of trial and error to find correct selectors
  end

  def self.scrape_profile_page(profile_url)
    #scraping individual student profile page to get further info
    #return value is hash of key/value pairs describing a student
    #scrapes twitter, linkedin, github, blog, profile quote, bio--also allows for when these aren't provided
    
  end

end

