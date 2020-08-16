require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    student_array = []
    doc = Nokogiri::HTML(open("#{index_url}"))
    students = doc.css(".student-card")
    students.each do |student|
      hash = { name: student.css(".card-text-container h4").text,
               location: student.css(".card-text-container p").text,
               profile_url: "#{student.css("a")[0]["href"]}"
      }
      student_array << hash
    end
    student_array
  end
  
  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container").children.css("a").map do |x|
      x.attribute("href").value
    end 
    
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else 
        student[:blog] = link
      end
    end
    
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css(".div.bio-content.content-holder div.description-holder p").text
    
    student
  end

end

