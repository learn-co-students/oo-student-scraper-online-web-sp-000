require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    #one name =  doc.css(".student-card").first.css(".student-name").text
    #one location = doc.css(".student-card").first.css(".student-location").text
    #one url = doc.css(".student-card").first.css("a").attribute("href").value
    doc.css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_info = {}
    # x = doc.css(".main-wrapper.profile .social-icon-container a").attribute(href).value
    doc.css(".main-wrapper.profile .social-icon-container a").each do |sic|
      if sic.attribute("href").value.include?("twitter")
        profile_info[:twitter] = sic.attribute("href").value
      elsif sic.attribute("href").value.include?("linkedin")
        profile_info[:linkedin] = sic.attribute("href").value
      elsif sic.attribute("href").value.include?("github")
        profile_info[:github] = sic.attribute("href").value
      else
        profile_info[:blog] = sic.attribute("href").value
      end
     end
     
       profile_info[:profile_quote] = doc.css(".main-wrapper.profile .vitals-text-container .profile-quote").text
       profile_info[:bio] = doc.css(".main-wrapper.profile .details-container .description-holder p").text
      
  
    profile_info
  end

end

