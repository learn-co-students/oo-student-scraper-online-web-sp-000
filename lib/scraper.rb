require 'open-uri'
require 'pry'

class Scraper

def self.scrape_index_page(index_url)
  
  doc = Nokogiri::HTML(open(index_url))
  scraped_students = []
  students = doc.css(".student-card") 
  students.each do |studentinfo|
    student = {
      :name => studentinfo.css("h4.student-name").text,
      :location => studentinfo.css("p.student-location").text,
      :profile_url => studentinfo.css("a").attribute("href").value
    }
  scraped_students << student
end
scraped_students
end 



def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".main-wrapper.profile .social-icon-container a").each do |social|
      if (social.attribute("href").value.include?("twitter"))
        student_hash[:twitter] = social.attribute("href").value
      elsif (social.attribute("href").value.include?("linkedin"))
        student_hash[:linkedin] = social.attribute("href").value
      elsif (social.attribute("href").value.include?("github"))
        student_hash[:github] = social.attribute("href").value
      else (social.attribute("href").value.include?("blog"))
        student_hash[:blog] = social.attribute("href").value
  end #end of iterator
end #end of boolean

student_hash[:profile_quote] = doc.css(".main-wrapper.profile .vitals-text-container .profile-quote").text
student_hash[:bio] = doc.css(".main-wrapper.profile .details-container .description-holder p").text

student_hash 

end #end of method?


end 