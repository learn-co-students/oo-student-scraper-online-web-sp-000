require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    i_html = open(index_url)
    doc = Nokogiri::HTML(i_html)
    student_info = doc.css(".student-card")
    students = []

    student_info.map do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)
  	  i_html = open(profile_url)
    	doc = Nokogiri::HTML(i_html)
    	student_info = doc.css(".vitals-container")
    students = {}

    student_info.css('a').each do |social|
    	if social.attribute("href").value.include?("twitter")
	    	students[:twitter] = social.attribute("href").value

	    elsif social.attribute("href").value.include?("github")
	    	students[:github] = social.attribute("href").value

	    elsif social.attribute("href").value.include?("linkedin")
	    	students[:linkedin] = social.attribute("href").value if social.attribute("href").value.include?("linkedin")
	    else
	    	students[:blog] =  social.attribute("href").value
	    end
  	end

  	students[:profile_quote] = student_info.css(".profile-quote").text if student_info.css(".profile-quote")

  	student_info = doc.css(".bio-content .description-holder")

  	students[:bio] = student_info.css('p').first.text if student_info.css('p')

  	students
  end

  
end
