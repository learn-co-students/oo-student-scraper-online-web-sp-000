require 'open-uri'
require 'pry'

class Scraper
html = open('fixtures/student-site/index.html')

attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
        student_array = []
     
    doc = Nokogiri::HTML(open(index_url)) 
   
      doc.css("div.roster-cards-container").each do |studentcard|
      studentcard.css(".student-card a").each do |s|
    name = s.css('.student-name').text
    location = s.css('.student-location').text
    profile_url =  "#{s.attr('href')}"
    student_array << {name: name, location: location, profile_url: profile_url}
  end
end
student_array
end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile = Nokogiri::HTML(open(profile_url))
    
     student[:profile_quote] = profile.css(".profile-quote").text
    student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text 
    links = profile.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    if links != nil
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
  end
  student
end
end

