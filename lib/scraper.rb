require 'open-uri'
require 'pry'

=begin
1. student cards: page.css("div.roster-cards-container").each do |card|
2. profile_url: card.css(".student-card a").each do |student|
  "#{student.attr('href')}"
3. student name: student.css('.student-name').text
4. student location: student.css('.student-location').text
=end

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []

    page.css('div.roster-cards-container').each do |card|
      card.css('.student-card a').each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_profile_url = "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students    
  end



  def self.scrape_profile_page(profile_url)
    
  end

end




=begin
s = Scraper.new
page = s.class.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/")
=end
