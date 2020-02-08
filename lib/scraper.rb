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
    profile = doc.css(".main-wrapper.profile")
    binding.pry 
    student_profile = {
      :twitter => profile.css("a").attribute("href").value,
      :linkedin => profile.css("a").attribute("href").value,
      :github => profile.css("a").attribute("href").value,
      :blog => profile.css("a").attribute("href").value,
      :profile_quote => profile.css(".profile-quote").text, 
      :bio => profile.css("p.description-holder").text 
    }
    student_profile 
  end
end

