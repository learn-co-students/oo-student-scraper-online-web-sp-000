require 'open-uri'
require 'nokogiri'
require 'pry'
#require_relative '../fixtures/student-site/index.html'

class Scraper
  #we don't to create instances of Scraper that maintain their own attributes
  #we just need to scrap info and pass to student
  #therefore we only need class methods

  def self.scrape_index_page(index_url) #return an array of hashes, each has represent a student
    #have keys name, location, and profile url
    array_of_students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card")
    student_cards.each do |student_card|
      student_hash = {
        :name => student_card.css("h4.student-name").text,
        :location => student_card.css("p.student-location").text,
        :profile_url => student_card.css("a").attribute("href").value
      }
      array_of_students << student_hash
    end
    array_of_students
    
    #name: student_card.css("h4.student-name").text
    #location: student_card.css("p.student-location").text
    #url: student_card.css("a").attribute("href").value
    #binding.pry
    
    
  end

  def self.scrape_profile_page(profile_url)
    #return hash of student
    #linkedin, github, blog, profile_quote, bio
    
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    
    #controlling for no social link
    #(doc.css(".social-icon-container a")[0] == nil)? twitter = "" : twitter = doc.css(".social-icon-container a")[0].attribute("href").value
    #(doc.css(".social-icon-container a")[1] == nil)? linkedin = "" : linkedin = doc.css(".social-icon-container a")[1].attribute("href").value
    #(doc.css(".social-icon-container a")[2] == nil)? github = "" : github = doc.css(".social-icon-container a")[2].attribute("href").value
    #(doc.css(".social-icon-container a")[3] == nil)? github = "" : blog = doc.css(".social-icon-container a")[3].attribute("href").value
    #binding.pry
    
    linkedin = nil
    twitter = nil
    github = nil
    blog = nil
    
    array_of_socials = doc.css(".social-icon-container a")
    array_of_socials.each do |social| #for each social link set equal to whichever it is
      #binding.pry
      link = social.attribute("href").value
      if link.include?("linkedin")
        linkedin = link
      elsif link.include?("twitter")
        twitter = link
      elsif link.include?("github")
        github = link
      else
        blog = link
      end
    end
    
    
    student = {
    #  :twitter => twitter,
    #  :linkedin => linkedin,
    #  :github => github,
    #  :blog => blog,
      :profile_quote => doc.css(".profile-quote").text,
      :bio => doc.css(".description-holder p").text
    }
    
    student[:twitter] = twitter if twitter != nil
    student[:linkedin] = linkedin if linkedin != nil
    student[:github] = github if github != nil
    student[:blog] = blog if blog != nil
    
    student
    #binding.pry
    
    #linkedin: doc.css(".social-icon-container a")[1].attribute("href").value
    #github: doc.css(".social-icon-container a")[2].attribute("href").value
    #blog: 
    #profile_quote: doc.css(".profile-quote").text
    #bio: doc.css(".description-holder p").text
  end

end

