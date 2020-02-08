require 'open-uri'
require 'nokogiri'
require 'pry'
require_relative './student.rb'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    studentArr = []
    students = doc.css(".student-card") 
    students.each do |student|
      student = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value  
      }
      studentArr << student 
    end 
    studentArr 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
  end
end

# attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 
#name 
#location 
#twitter 
#linkedin 
#github 
#blog 
#profile quote 
#bio 
#profile url 