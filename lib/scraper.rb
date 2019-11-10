require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_profile_url = "#{student.attr("href")}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css("div.social-icon-container").children.css("a").collect {|a| a.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end

    student[:profile_quote] = profile_page.css("div.profile-quote").text if profile_page.css("div.profile-quote")
    student[:bio] = profile_page.css("div.description-holder p").text if profile_page.css("div.description-holder p")
    student
  end

end
