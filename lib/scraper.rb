require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    studes = doc.css('.student-card')
    studes.each do |student|
        scraped_students << {name: student.css(".student-name").text, location: student.css(".student-location").text, profile_url: student.css('a')[0]['href']}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    scraped_student = {}
    profile = doc.css('.vitals-container')
    social = doc.css('.vitals-container .social-icon-container a')
    twitter = social.find{|obj| obj['href'].include?("twitter")}
    linkedin = social.find{|obj| obj['href'].include?("linkedin")}
    github = social.find{|obj| obj['href'].include?("github")}
    blog = social.find{|obj| obj.at_css('img')['src'].include?("rss")}
    bio = doc.css('.details-container')
  
    scraped_student[:twitter] = twitter['href'] if twitter != nil
    scraped_student[:linkedin] = linkedin['href'] if linkedin != nil
    scraped_student[:github] = github['href'] if github != nil
    scraped_student[:blog] = blog['href'] if blog != nil
    scraped_student[:profile_quote] = profile.css('.vitals-text-container .profile-quote').text
    scraped_student[:bio] = bio.css('.description-holder p').text
    scraped_student
    
  end

end

