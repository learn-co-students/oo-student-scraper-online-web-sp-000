require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    array = []
    
    students.each do |student|
      s = {name: student.css("h4").text, location: student.css("p.student-location").text, profile_url: student.css("a").first["href"]
      }
      
      array << s 
    end
    
    array 
    
    
  end

  def self.scrape_profile_page(profile_url)
      doc = Nokogiri::HTML(open(profile_url))
      social = doc.css("a")
      number = social.count
      count = 1
      h = {}
    
    while count < number do
      github = social[count]["href"] unless social[count]["href"].include?("github") == false 
      linkedin = social[count]["href"] unless social[count]["href"].include?("linkedin") == false 
      twitter = social[count]["href"] unless social[count]["href"].include?("twitter") == false 
      blog = social[count]["href"] unless social[count]["href"].include?("twitter") == true || social[count]["href"].include?("github") == true || social[count]["href"].include?("linkedin") == true
      count += 1
    end
    

    h[:github] = github unless github == nil 
    h[:linkedin] = linkedin unless linkedin == nil 
    h[:twitter] = twitter unless twitter == nil 
    h[:blog] = blog unless blog == nil 
    h[:profile_quote] = doc.css(".profile-quote").text 
    h[:bio] = doc.css("p").text 
    h

    
    
    

  end

end

