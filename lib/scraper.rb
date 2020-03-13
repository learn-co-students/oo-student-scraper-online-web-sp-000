require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students_xml = doc.css(".student-card")
    students_xml.each do |student|
    	student_name = student.css(".student-name").text
    	student_location = student.css(".student-location").text
    	student_url = student.css("a").attribute("href").value

    	students << {
    		name: student_name,
    		location: student_location,
    		profile_url: student_url
    	}
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    
    student_details = {}
    profile_xml = doc.css(".main-wrapper.profile")
    # binding.pry

    doc.css(".main-wrapper.profile a").each do |item|
        if item.attribute("href").value.include?("twitter")
            student_details[:twitter] = item.attribute("href").value
        elsif item.attribute("href").value.include?("linkedin")
            student_details[:linkedin] = item.attribute("href").value
        elsif item.attribute("href").value.include?("github")
          student_details[:github] = item.attribute("href").value
        elsif item.attribute("href").value.include?(".com")
            student_details[:blog] = item.attribute("href").value
        end
    end

    student_details[:profile_quote] = doc.css(".main-wrapper.profile").css(".profile-quote").text
    student_details[:bio] = doc.css(".main-wrapper.profile").css(".description-holder p").text
    
    student_details
    # binding.pry
  end
end



