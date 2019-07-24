require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    list_students = []
    students = {}
    doc.css(".student-card").each {|a| 
    students = {
      :name => a.css(".student-name").text,
      :location => a.css(".student-location").text,
      :profile_url => a.css("a").attr("href").value
    }
    list_students << students
    }
    #binding.pry
    list_students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    profile = {}
    #binding.pry
    #social_media = doc.css(".social-icon-container").css("a").attr("href")
    #if social_media.value.include?("twitter")
    profile[:twitter] = doc.css(".social-icon-container").css("a")[0].attr("href")
    #end
    #if social_media.value.include?("linkedin")
    profile[:linkedin] = doc.css(".social-icon-container").css("a")[1].attr("href")
    #end
    #if social_media.value.include?("github")
    profile[:github] = doc.css(".social-icon-container").css("a")[2].attr("href")
    #end
    #if social_media.value.include?("youtube")
    profile[:blog] = doc.css(".social-icon-container").css("a")[3].attr("href")
    #end
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder").first.text.strip
    profile
    
    
  end

end

