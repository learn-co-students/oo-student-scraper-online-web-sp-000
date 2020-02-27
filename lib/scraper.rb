require 'open-uri'
require 'pry'

class Scraper
  

  def self.scrape_index_page(index_url)
   students = []
    doc = Nokogiri::HTML(open(index_url))
  
    doc.css(".student-card").each do |person|
      students << {:name=>person.css(".student-name").text, :location=>person.css(".student-location").text, :profile_url=>person.css("a").attribute("href").value}
    end
   students
  end 

  def self.scrape_profile_page(profile_url)   
    doc = Nokogiri::HTML(open(profile_url))
     social_link= { }   
       doc.css(".vitals-container").each do |profile|

          links = profile.css(".social-icon-container a").collect {|link|link["href"]}
                links.detect do |socialMedia|
                      social_link[:twitter]= socialMedia if socialMedia.include?("twitter")
                      social_link[:linkedin]= socialMedia if socialMedia.include?("linkedin")
                      social_link[:github]= socialMedia if socialMedia.include?("github")
                      unless socialMedia.include?("twitter") ||socialMedia.include?("linkedin")||socialMedia.include?("github")
                      social_link[:blog] = socialMedia
                      end #unless
                end #detect
                  social_link[:profile_quote]= profile.css(".profile-quote").text
                  social_link[:bio] = doc.css(".description-holder p").text
              end #each
              social_link
          end #def
      end #class

