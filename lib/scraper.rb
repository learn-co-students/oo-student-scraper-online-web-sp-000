require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    website = Nokogiri::HTML(open(html))
    student_card = website.css("div.student-card")

    student_card.each do |student|
    ind_student = {}
    ind_student[:name] = student.css("h4.student-name").text
    ind_student[:location] = student.css("p.student-location").text
    ind_website = student.children[1].attributes["href"].value
    ind_student[:profile_url] =  ind_website
    students << ind_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_info = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    #binding.pry
    social_links = profile.css("div.main-wrapper.profile .social-icon-container a")
   
    social_links.each do |social|
    if social.attribute("href").value.include?("twitter")
        profile_info[:twitter] = social.attribute("href").value
    elsif social.attribute("href").value.include?("linkedin")
        profile_info[:linkedin] = social.attribute("href").value
    elsif social.attribute("href").value.include?("github")
        profile_info[:github] = social.attribute("href").value
    else
        profile_info[:blog] = social.attribute("href").value
    end
    end
    profile_info[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-container .profile-quote").text
    profile_info[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text 
    profile_info
  end
end

