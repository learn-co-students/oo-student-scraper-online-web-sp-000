require 'open-uri'
require 'pry'
require 'nokogiri'
require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    doc.css("div.student-card").each do |student|
      new_student = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      
      students << new_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    aspects = []
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social = doc.css("div.social-icon-container")
    social.css("a").each do |aspect|
      aspects << aspect.attribute("href").value
      
    end
    quote_div = doc.css("div.vitals-text-container")
    quote = quote_div.css("div.profile-quote").text
    bio_div = doc.css("div.description-holder")
    bio = bio_div.css("p").text
    twitter = aspects.find {|el| el.include?("twitter") }
    linkedin = aspects.find {|el| el.include?("linkedin") }
    github = aspects.find {|el| el.include?("github") }
    blog = aspects.find {|el| !el.include?("twitter") && !el.include?("linkedin") && !el.include?("github") }
    student_hash = {}
    student_hash[:twitter] = twitter if twitter != nil
    student_hash[:linkedin] = linkedin if linkedin != nil
    student_hash[:github] = github if github != nil
    student_hash[:blog] = blog if blog != nil
    student_hash[:profile_quote] = quote
    student_hash[:bio] = bio
    
    student_hash
  end
  
end
