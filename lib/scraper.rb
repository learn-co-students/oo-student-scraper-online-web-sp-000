require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_profile_url = "#{student.attr("href")}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end

#scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/")
  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    profile_info = {}
    social_links = profile.css("div.social-icon-container a")#.attribute("href").value
    social_links.each do |a|
      if a.attribute("href").value.include?("github")
        profile_info[:github] = a.attribute("href").value
      elsif a.attribute("href").value.include?("linkedin")
        profile_info[:linkedin] = a.attribute("href").value
      elsif a.attribute("href").value.include?("twitter")
        profile_info[:twitter] = a.attribute("href").value
      else
        profile_info[:blog] = a.attribute("href").value

      end
    end
    profile_info[:profile_quote] = profile.css("div.profile-quote").text
    profile_info[:bio] = profile.css("div.description-holder p").text
    #binding.pry
    profile_info
  end

  #scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ruth-mesfun.html")

end
