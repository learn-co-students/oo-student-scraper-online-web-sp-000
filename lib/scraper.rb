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
    student_profile = {
      :profile_quote => profile.css(".profile-quote").text, 
      :bio => profile.css("p").text 
    }
    profile.css(".social-icon-container").css("a").each do |icon| 
      if(icon.attribute("href").value.include?("twitter"))
        student_profile[:twitter] = icon.attribute("href").value
      elsif(icon.attribute("href").value.include?("linkedin"))
        student_profile[:linkedin] = icon.attribute("href").value 
      elsif(icon.attribute("href").value.include?("github"))
        student_profile[:github] = icon.attribute("href").value
      else 
        student_profile[:blog] = icon.attribute("href").value 
      end 
    end 
    student_profile 
  end
end

