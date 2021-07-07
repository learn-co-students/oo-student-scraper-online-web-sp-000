require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)

    html = open(index_url) 
    doc = Nokogiri::HTML(html)
    
    student_data = []
    profile_data = {}
    
    doc.css("div.student-card").each do |profile|
      name = profile.css("h4.student-name").text
      
      location = profile.css("p.student-location").text
      
      profile_url = profile.css("a").attribute("href").value
    
      profile_data = {:name => name, :location => location, :profile_url => profile_url}
      
      student_data << profile_data
    end
    student_data
  end




  def self.scrape_profile_page(profile_url)
    html = open(profile_url) 
    new_doc = Nokogiri::HTML(html)

    elements = new_doc.css("div.social-icon-container a")
    social_network_num = new_doc.css("div.social-icon-container a").length 
    index = 0
  
    individual_student = {}
    
    while index < social_network_num
      url_link = elements[index].attribute("href").value
      index += 1
      if url_link.include?("twitter")
        individual_student[:twitter] = url_link
      elsif url_link.include?("github")
        individual_student[:github] = url_link
      elsif url_link.include?("linkedin")
        individual_student[:linkedin] = url_link
      else
        individual_student[:blog] = url_link
      end
    end
  
    
    individual_student[:profile_quote] = new_doc.css("div.profile-quote").text
  
    
    individual_student[:bio] = new_doc.css("div.bio-content.content-holder div.description-holder p").text
    

    individual_student
  end

end

