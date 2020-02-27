require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)
    students = []
    index_page.css("div.student-card").each do |student|
      this_student = {}
      this_student[:name] = student.css("h4.student-name").text
      this_student[:location] = student.css("p.student-location").text
      this_student[:profile_url] = student.css("a").attribute("href").value
      students << this_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    student_details = {}
    social_networks = profile_page.css("div.social-icon-container a").collect{|network| network.attribute("href").value}
    social_networks.each do |link|
      if link.include?("twitter")
        student_details[:twitter] = link
      elsif link.include?("linkedin")
        student_details[:linkedin] = link
      elsif link.include?("github")
        student_details[:github] = link
      else
        student_details[:blog] = link
      end
    end
    student_details[:profile_quote] = profile_page.css("div.profile-quote").text
    student_details[:bio] = profile_page.css("div.description-holder p").text
    student_details
  end

end
