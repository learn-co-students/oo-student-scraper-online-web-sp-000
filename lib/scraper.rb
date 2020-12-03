require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
    doc = Nokogiri::HTML(open(index_url))
    
    id_cards = doc.css(".student-card")
    
    array = [ ]
    
    id_cards.each do |student_card|
      array << {
        #student name
        name: student_card.css("h4.student-name").text,
      
      #student location
      location: student_card.css("p.student-location").text,
      
      #profile_url
      profile_url: student_card.css("a").attribute("href").value
      }
    end
      array
  end
  

  def self.scrape_profile_page(profile_url)
    
    doc = Nokogiri::HTML(open(profile_url))
    #creating the indvidual student hash
    student_info = {
      #profile quote
      profile_quote: doc.css(".vitals-text-container div").text,
      
      #bio
      bio: doc.css(".details-container p").text
    }
    
    doc.css(".social-icon-container a").each do |socials|
      if socials.attribute("href").value.include?('twitter')
        student_info[:twitter] = socials.attribute("href").value
      elsif socials.attribute("href").value.include?('github')
        student_info[:github] = socials.attribute("href").value
      elsif socials.attribute("href").value.include?('linkedin')
        student_info[:linkedin] = socials.attribute("href").value
      else
        student_info[:blog] = socials.attribute("href").value
      end
    end
    student_info
  end
  
end

