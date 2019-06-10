require 'open-uri'
require 'nokogiri'


class Scraper

  @@scraped_students = []

  
  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
       
    html.css(".student-card").each do |student| 
      student_name = student.css(".student-name").text 
      student_name_url = student_name.split(" ").join("-").downcase
      student_location = student.css(".student-location").text
      student_profile = "students/#{student_name_url}.html"
      hash = {:name => student_name, :location => student_location, :profile_url => student_profile}
      @@scraped_students << hash 
    end 
      @@scraped_students
   
  end

  def self.scrape_profile_page(profile_url)
    
     html = Nokogiri::HTML(open(profile_url))
     
      hash = {}
          
          if html.css(".description-holder p") != nil
            bio = html.css(".description-holder p").text 
            hash[:bio] = bio
          end 
          
          if html.css(".profile-quote") != nil
            profile_quote = html.css(".profile-quote").text 
            hash[:profile_quote] = profile_quote
          end 
          
          if html.css(".social-icon-container a")
            social_media = html.css(".social-icon-container").children.css("a").collect do |link|
              link.attribute("href").value 
            end 
            
            social_media.each do |page| 
              if page.include?("linkedin")
                hash[:linkedin] = page 
              elsif page.include?("github")
                hash[:github] = page 
              elsif page.include?("twitter")
                hash[:twitter] = page 
              else 
                hash[:blog] = page 
              end 
            end 
          end 
        hash 
  end

end

