require 'open-uri'
require 'pry'

=begin
Student Array:
1. student cards: page.css("div.roster-cards-container")
2. profile_url: card.css(".student-card a")
    "#{student.attr('href')}"
3. student name: student.css('.student-name').text
4. student location: student.css('.student-location').text
=end


class Scraper

  def self.scrape_index_page(index_url)
    students = []
    page = Nokogiri::HTML(open(index_url))

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
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))

    links = profile_page.css(".social-icon-container").children.css("a").map {|link| link.attribute('href').value}

    links.each do |link|
      
      if link.include?('twitter')
        student[:twitter] = link
      elsif link.include?('linkedin')
        student[:linkedin] = link
      elsif link.include?('github')
        student[:github] = link
      elsif
        student[:blog] = link
      end
    end

    student[:profile_quote] = profile_page.css('.profile-quote').text if profile_page.css('.profile-quote').text
    student[:bio] = profile_page.css('div.bio-content.content-holder div.description-holder p').text if profile_page.css('div.bio-content.content-holder div.description-holder p').text

    student
    

    
  end

end

=begin
links => profile_page.css(".social-icon-container").children.css("a").map {|link| link.attribute('href').value}
:twitter => profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value => check if link includes twitter
:linkedin => profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value => check if link includes linkedin
:github => profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value => check if link includes github
:blog => profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value => check if link includes blog
:profile_quote => profile_page.css('.profile-quote').text => check for profile quote
:bio => profile_page.css('div.bio-content.content-holder div.description-holder p').text
=end





=begin
s = Scraper.new
page = s.class.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")

profile_page = s.class.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html")
=end
