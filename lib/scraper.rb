require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").css("a").each do |x|
      namevalue = x.css(".student-name").text
      locationvalue = x.css(".student-location").text
      url = x.attributes["href"].value
      scraped_students << {name: namevalue, location: locationvalue, profile_url: url}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    eachstudent = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container").css("a").each do |x|
      if x.attributes["href"].value.include?("twitter") 
        twittervalue = x.attributes["href"].value
        eachstudent[:twitter] = twittervalue
      elsif x.attributes["href"].value.include?("linkedin")
        linkedinvalue = x.attributes["href"].value
        eachstudent[:linkedin] = linkedinvalue
      elsif x.attributes["href"].value.include?("github")
        githubvalue = x.attributes["href"].value
        eachstudent[:github] = githubvalue
      else 
        blogvalue = x.attributes["href"].value
        eachstudent[:blog] = blogvalue  
      end
    quote = doc.css(".profile-quote").text
    eachstudent[:profile_quote] = quote
    biovalue = doc.css("p").text
    eachstudent[:bio] = biovalue
    end
    eachstudent
  end

end

