require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |student|
      hash = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
      students << hash 
    end
    students
  end

  def self.scrape_profile_page(profile_url)

    students = {}
    
    profile = Nokogiri::HTML(open(profile_url))
    social = profile.css(".social-icon-container a")
    social.each do |link|
      link = link.attribute("href").value 
      if link.include?("twitter")
        students[:twitter] = link
      elsif link.include?("linkedin")
       students[:linkedin] = link 
      elsif link.include?("github")
       students[:github] = link
      else
       students[:blog] = link
      end
    end
    students[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    students[:bio] = profile.css(".description-holder p").text
    students
  end	  
  end