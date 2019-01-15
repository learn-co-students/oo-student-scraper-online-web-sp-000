require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor 

  def self.scrape_index_page(index_url)
    
    index_url = File.read('fixtures/student-site/index.html')
    profiles_page = Nokogiri::HTML(index_url)
    
    students = []
    profile_hash = {}
    #find name, location and profile url
      
      
      #each profile lives here
      #profiles.css("div.student-card")
      
      profiles_page.css("div.student-card").each do |profile| 
        
        profile_hash = {:name => profile.css("div.card-text-container h4.student-name").text, :location => profile.css("div.card-text-container p.student-location").text, :profile_url => profile.css("a").attribute("href").value}
        
        students << profile_hash
        
        
      end 
      
      
    return students
    
    
  end

  def self.scrape_profile_page(profile_url)
    
    #this retrieves students array from other method 
    students_overall = self.scrape_index_page(profile_url)
    #binding.pry
    
    #this isolates student urls into new array
    i = 0 
    just_url = []
   while i < students_overall.length 
      url = students_overall[i][:profile_url] 
      i += 1 
      just_url << url
   end 
   
   #creates array each needed individual url for each student 
   pages_prefix = 'fixtures/student-site/students/'
    individual_urls = [] 
    just_url.each do |modify| 
        indiv_student = pages_prefix + "#{modify}" 
        
        individual_urls << indiv_student
        
      end 
      
      
      #needs to look for linkedin, github, blog, quote, bio
      j = 0 
      
      while j < individual_urls.length 
       
      profile_url = File.read(individual_urls[j])
      student_attributes = Nokogiri::HTML(profile_url)
        

  
 
    # profile_url = File.read('fixtures/student-site/students/')
    # individual_page = Nokogiri::HTML(profile_url)
    
    # student_details = {}
    
    
    
    
    
    
    
  end

end

