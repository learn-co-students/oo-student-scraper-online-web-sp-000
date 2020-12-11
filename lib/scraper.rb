require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = "#{student.css("a").attribute("href").value}"
      students << {name: name, location: location, profile_url: profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_info = {}
    links = doc.css("div.social-icon-container a").collect {|link| link.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        student_info[:twitter] = link
      elsif link.include?("linkedin")
        student_info[:linkedin]= link
      elsif link.include?("github")
        student_info[:github] = link
      else
        student_info[:blog] = link
      end
    end
      student_info[:profile_quote] = doc.css("div.profile-quote").text
      student_info[:bio] = doc.css("div.description-holder p").text
      student_info
  end

end
