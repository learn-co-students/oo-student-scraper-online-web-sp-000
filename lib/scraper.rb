require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    list = Nokogiri::HTML(html)
    names = list.css("div.student-card a"). each do |student|
     info = {}
     info[:name] = student.css("h4.student-name").text
     info[:location] = student.css("p.student-location").text
     info[:profile_url] = student.attr("href")
     students << info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
   student_profile = {}
   html = open(profile_url)
   profile = Nokogiri::HTML(html)

   profile.css("div.main-wrapper.profile .social-icon-container a").each do |social_media|
    if social_media.attribute("href").value.include?("twitter")
      student_profile[:twitter] = social_media.attribute("href").value
    elsif social_media.attribute("href").value.include?("linkedin")
      student_profile[:linkedin] = social_media.attribute("href").value
    elsif social_media.attribute("href").value.include?("github")
      student_profile[:github] = social_media.attribute("href").value
    else
      student_profile[:blog] = social_media.attribute("href").value
    end
  end
  student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
  student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text
  student_profile


  end
end
