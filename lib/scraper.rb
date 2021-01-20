require 'open-uri'
require 'pry'

class Scraper

 def self.scrape_index_page(index_url) #Making the code flexible bu not enterting the website directly
  html = open(index_url) #html = open URL

  page = Nokogiri::HTML(html) #page = the URL and lets us use Nokogiri keywrods and methods
     #binding.pry
     
    students = [] #End results need to be an Array with different hashes [ {:name => "nabeil", :location => "NY"}, {:name => "jason", :location => "CA"}. {  }, {  }]
    
    page.css("div.student-card").each do |student| #Need to use css to inspect the file and find the "common theme" of all the student #profiles, need to then use the each enumerator to loop through each one 
      
      students << {  #since we want the profile info in hashes need to push everything in the array each profile set will have { }
      :name => student.css("h4.student-name").text, #Key =:namev value = student-name, h4 is category, classname is student-name
      :location => student.css("p.student-location").text, # p = category , class name is student-location 
      :profile_url => student.children[1].attributes["href"].value
      }
    end 
    students
  end 
  
  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    
    #binding.pry
    
    student_page = {}
    
    social_links = profile_page.css(".social-icon-container").css("a").collect {|link| link.attributes["href"].value}
    
    social_links.detect do |link|
      student_page[:twitter] = link if link.include?("twitter")
      student_page[:linkedin] = link if link.include?("linkedin")
      student_page[:github] = link if link.include?("github")
      
    end 
    
      student_page[:blog] = social_links[3] if social_links[3] != nil 
      student_page[:profile_quote] = profile_page.css(".profile-quote")[0].text
      student_page[:bio] = profile_page.css("div.description-holder")[0].children.css('p').text
      #student_page[:bio] = profile_page.css(".description-holder").css('p')[0].text
      student_page
    
  end

end


#index_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"
#self.scrape_profile_page(index_url)
