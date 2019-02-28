require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    page  = Nokogiri::HTML(open(index_url))
    
    c = page.css("div.student-card")
    
      c.collect do |info|
        student_hash =  {:name => info.css("h4.student-name").text, 
                       :location => info.css("p.student-location").text, 
                       :profile_url => info.css("a").attribute("href").value}
        students << student_hash
      end
      students
    end
   

  def self.scrape_profile_page(profile_url)
    profile = {}
    page = Nokogiri::HTML(open(profile_url))
    s = page.css("div.social-icon-container a")
    
    s.each do |info|
      case info.attribute('href').value
        when /twitter/
        profile[:twitter] = info.attribute('href').value
       
        when /linkedin/
        profile[:linkedin] = info.attribute('href').value
        
        when /github/
        profile[:github] = info.attribute('href').value
        
        else
        profile[:blog] = info.attribute('href').value
        
        end 
      end
       profile[:profile_quote] = page.css("div.vitals-text-container").css(".profile-quote").text
       profile[:bio] = page.css("div.description-holder").css("p").text
    
    profile
  end
  
  
end
