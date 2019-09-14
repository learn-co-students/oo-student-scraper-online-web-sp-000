require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    index_html = Nokogiri::HTML(open(index_url))
    student_index_array = []
    index_html.css("div.roster-cards-container").each do |student_card|
      student_card.css(("div.student-card a")).each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_profile_url = student.attr('href')
        student_index_array << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    profile_html = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    outside_links = profile_html.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    outside_links.each do |link|
      if link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      elsif link.include?("twitter")
        student_profile[:twitter] = link
      else
        student_profile[:blog] = link
      end
      student_profile[:profile_quote] = profile_html.css(".profile-quote").text if profile_html.css(".profile-quote")
      student_profile[:bio] = profile_html.css("div.bio-content.content-holder div.description-holder p").text if profile_html.css("div.bio-content.content-holder div.description-holder p")
    end
    student_profile
  end

end

#All info about all students: index_html.css("div.roster-cards-container").text
#Student's individual information: index_html.css("div.student-card").text
#Student's name: index_html.css("h4.student-name").text
#Student's location: index_html.css("p.student-location").text
#Student's profile url: index_html.css(".student-card a").attr('href').value
