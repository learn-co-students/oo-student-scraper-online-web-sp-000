require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student|
     hash =  {
     :name => student.css(".student-name").text,
     :location => student.css(".student-location").text,
     :profile_url => student.css("a").attribute("href").value
    }
    students << hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    student_array = doc.css(".social-icon-container").children.css("a").map { |element| element.attribute('href').value }

    student_array.each do |info|
      if  info.include?("twitter")
        student_hash[:twitter] = info
      elsif info.include?("linkedin")
        student_hash[:linkedin] = info 
      elsif info.include?("github")
        student_hash[:github] = info
      else 
        student_hash[:blog] = info
      end
    end
    student_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text 
    student_hash[:bio] = doc.css(".details-container .description-holder p").text 
    student_hash
  end

end

