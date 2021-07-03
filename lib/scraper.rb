require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    
    website = Nokogiri::HTML(open(index_url))
    
    website.css(".student-card").collect do |student|
        attributes = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").text
    
        }
              
        scraped_students << attributes
        
      end
    scraped_students
  end



  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    
    html = Nokogiri::HTML(open(profile_url))
    
     html.css(".social-icon-container a").each do |student|
        url = student.attribute("href").text
     
        scraped_student[:twitter] = url if url.include?("twitter")
        scraped_student[:linkedin] = url if url.include?("linkedin")
        scraped_student[:github] = url if url.include?("github")
        scraped_student[:blog] = url if student.css("img").attribute("src").text.include?("rss")
    end
    
        scraped_student[:profile_quote] = html.css("div.vitals-text-container div").text
        scraped_student[:bio] = html.css("div.bio-content p").text
        scraped_student
   end


end

