require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index = Nokogiri::HTML(open(index_url))

    index.css("div.roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each do |student|
      student_name = student.css(".student-name").text
      student_location = student.css(".student-location").text
      student_profile_url = "#{student.attr("href")}"

      students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end


 def self.scrape_profile_page(profile_url)
   student_profile = {}
   profile = Nokogiri::HTML(open(profile_url))

   social_links = profile.css("div.social-icon-container a")#.attribute("href").value
   social_links.each do |s|
     if s.attribute("href").value.include?("github")
      student_profile[:github] = s.attribute("href").value
      elsif s.attribute("href").value.include?("linkedin")
      student_profile[:linkedin] = s.attribute("href").value
      elsif s.attribute("href").value.include?("twitter")
      student_profile[:twitter] = s.attribute("href").value
      else
      student_profile[:blog] = s.attribute("href").value
      end
    end
    
   student_profile[:profile_quote] = profile.css("div.profile-quote").text
   student_profile[:bio] = profile.css("div.description-holder p").text
   student_profile
 end
end
