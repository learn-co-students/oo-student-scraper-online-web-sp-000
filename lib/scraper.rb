require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = [] 
    index_page.css(".roster-cards-container").each do |card|
    card.css(".student-card a").each do |student| 
    student_name = student.css(".student-name").text
    student_location = student.css(".student-location").text
    student_url = student.attr("href")
   
    students << {:name => student_name, :location => student_location, :profile_url => student_url} 
      end 
    end 
    students 
  end

  def self.scrape_profile_page(profile_url)
    index_page = Nokogiri::HTML(open(profile_url))
    profile_info = {}
    index_page.css(".social-icon-container a").each do |links|
    link = links.attribute("href").text 
    profile_info[:twitter] = link if link.include?("twitter")
    profile_info[:linkedin] = link if link.include?("linkedin")
    profile_info[:github] = link if link.include?("github")
    profile_info[:blog] = link if links.css("img").attribute("src").text.include?("rss")
  end

  profile_info[:profile_quote] = index_page.css(".profile-quote").text 
  profile_info[:bio] = index_page.css("p").text
  profile_info
  end 

end

