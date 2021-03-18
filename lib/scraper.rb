require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
   doc = Nokogiri::HTML(html)
   student = {}
   student[:profile_quote] = doc.css('.profile-quote').text
   student[:bio] = doc.css('.description-holder p').text
   doc.css('.social-icon-container a').each do |tag|
     url = tag.attribute('href').value
     if url.include?("twitter")
       student[:twitter] = url
     elsif url.include?('linkedin')
       student[:linkedin] = url
     elsif url.include?('github')
       student[:github] = url
     else
       student[:blog] = url
     end
   end
   student
 end

end
