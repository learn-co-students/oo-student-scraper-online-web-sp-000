require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    #scrapes the index page that lists all of the students
    student_list = []

    html = Nokogiri::HTML(open(index_url))
    roster = html.css("div.student-card") #iterate over this

    roster.each do |student|
       #keys: name, location, profile_url
        student_dict = {}
        student_dict[:name] = student.css("h4.student-name").text
        student_dict[:location] = student.css("p.student-location").text
        student_dict[:profile_url] = student.css("a").attribute("href").value
        student_list << student_dict
      end
      student_list
  end


  def self.scrape_profile_page(profile_url)
    #scrapes an individual student's profile page to get further information about that student
    student_hash = {}
    html = Nokogiri::HTML(open(profile_url))
    profile_dict = {}
    social_profile = html.css("div.social-icon-container a")
    social_profile = social_profile.collect do |social|
      social.attribute("href").value
    end

    social_profile.each do |link|
      if link.include?("twitter")
        profile_dict[:twitter] = link
      elsif link.include?("linkedin")
        profile_dict[:linkedin] = link
      elsif link.include?("github")
        profile_dict[:github] = link
      elsif link.include?("http://")
        profile_dict[:blog] = link
      end
    end
    profile_dict[:profile_quote] = html.css("div.profile-quote").text
    profile_dict[:bio] = html.css("div.description-holder")[0].text.strip
    profile_dict
  end

end
