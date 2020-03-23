require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = Array.new
    
    doc.css("div.student-card").each do |student|
      students << {:name => student.css("h4.student-name").text, :location => student.css("p.student-location").text, :profile_url => student.css("a").attribute("href").value}
    end
    students
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = Hash.new(0)
    
    doc.css("div.main-wrapper.profile .social-icon-container a").each do |profile|
      if profile.attribute("href").value.include?("twitter")
        student_profile[:twitter] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = profile.attribute("href").value
      elsif profile.attribute("href").value.include?("github")
        student_profile[:github] = profile.attribute("href").value
      else
        student_profile[:blog] = profile.attribute("href").value
      end
    end
      student_profile[:profile_quote] = doc.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
      student_profile[:bio] = doc.css("div.main-wrapper.profile .details-container p").text
    student_profile
  end

end

