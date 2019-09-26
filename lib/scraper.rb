require 'open-uri'
require 'pry'

class Scraper
  
 
  def self.scrape_index_page(index_url)
      student_array = []
      student_hash = {}
      index_page = Nokogiri::HTML(open(index_url))
      student_html = index_page.css("div.student-card")
      student_html.each do |student|  
      student_hash = {name: student.css(".student-name").text, location: student.css(".student-location").text, profile_url: student.css("a").attr("href").value}
      student_array << student_hash    
     # binding.pry  
    
                         end
  
     student_array

  end

  def self.scrape_profile_page(profile_url)
     attributes = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    #binding.pry
    student = profile_page.css("div.social-icon-container").children
     student.each do |student|
     
     # binding.pry
      # if value includes twitter
      #   add attributes[:twitter] = value
      # elsif value includes linked in
     #elsif
     #else
     # add blog to attributes
      # add linekddin
    #  attributes =  {twitter: student.attributes["href"].value, linkedin: student[3].attributes["href"].value, github: student[5].attributes["href"].value, blog: student[7].attributes["href"].value, profile_quote: profile_page.css("div.profile-quote").text, bio: profile_page.css("div.description-holder p").text}
      if student.attributes["href"].value.include?("twitter")
        attributes[:twitter] = student.attributes["href"].value
      elsif student.attributes["href"].value.include?("linkedin")
        attributes[:linkedin] = student.attributes["href"].value
      elsif student.attributes["href"].value.include?("github")
        attributes[:github] = student.attributes["href"].value
      elsif student.attributes["href"].value.include?("linkedin")
        attributes[:linkedin] = student.attributes["href"].value
      elsif student.attributes["href"].value.include?("profile_quote")
        attributes[:profile_quote] = student.attributes["href"].value
      else
        nil   

    
    
                     end 
                     attributes
                    end 
                     #binding.pry
    
              
  end 
  #   student = profile_page.css
    # binding.pry
  end