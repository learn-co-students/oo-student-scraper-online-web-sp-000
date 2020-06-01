require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :doc

  def self.scrape_index_page(index_url)
    student_hashes = []
    html = Nokogiri::HTML(open(index_url))
    students = html.css(".student-card")
    students.each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile = student.css("a").attribute("href").value
      student_hashes << {:name => name, :location => location, :profile_url => profile}
    end
    student_hashes
  end

  def self.scrape_profile_page(profile_url)
    profile_hashes = {}
    html = Nokogiri::HTML(open(profile_url))

    socials = html.css(".social-icon-container a")
    socials.each do |social|
      current_url = social.attribute("href").value
      current_url.include?("twitter") ? profile_hashes[:twitter] = current_url : false
      current_url.include?("linkedin") ? profile_hashes[:linkedin] = current_url : false
      current_url.include?("github") ? profile_hashes[:github] = current_url : false
      social.css("img").attribute("src").value.include?("rss") ? profile_hashes[:blog] = current_url : false
    end

    
    profile_quote = html.css(".profile-quote").text
    bio = html.css(".description-holder p").text
    (profile_quote != nil) ? profile_hashes[:profile_quote] = profile_quote : false
    (bio != nil) ? profile_hashes[:bio] = bio : false
    
    puts profile_hashes
    profile_hashes
  end

end

#Binding.pry

#Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/")
#Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/david-kim.html")