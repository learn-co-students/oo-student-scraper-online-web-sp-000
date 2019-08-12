require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |student|
      students_hash = {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").value
      }
      students << students_hash
      students_hash = {}
    end
    students
# name: student.css("h4.student-name").text
# location: student.css("p.student-location").text
# twitter:
# linkedin:
# github:
# blog:
# profile_quote:
# bio:
# profile_url: student.css("a").attribute("href").value
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    doc.css("div.social-icon-container a").each do |info|
      if
        info.attribute("href").value.include? "twitter"
        student_profile[:twitter] = info.attribute("href").value
      elsif
       info.attribute("href").value.include? "linkedin"
        student_profile[:linkedin] = info.attribute("href").value
      elsif
       info.attribute("href").value.include? "github"
        student_profile[:github] = info.attribute("href").value
      else
        student_profile[:blog] = info.attribute("href").value
      end
    end
    student_profile[:profile_quote] = doc.css("div.profile-quote").text
    student_profile[:bio] = doc.css("div.description-holder p").text
    student_profile
  end

end
