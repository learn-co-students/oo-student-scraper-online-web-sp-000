require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor :students

  def self.scrape_index_page(index_url)
    #previous
    # index_url = File.read('fixtures/student-site/index.html')
    # profiles_page = Nokogiri::HTML(index_url)
    
    html = File.read(index_url)
      profiles_page = Nokogiri::HTML(html)
    
    @students = []
    profile_hash = {}
    #find name, location and profile url
      #each profile lives here
      #profiles.css("div.student-card")
      
      profiles_page.css("div.student-card").each do |profile| 
        
        profile_hash = {:name => profile.css("div.card-text-container h4.student-name").text, :location => profile.css("div.card-text-container p.student-location").text, :profile_url => profile.css("a").attribute("href").value}
        
        @students << profile_hash
      end 
      
    return @students
    
  end

  def self.scrape_profile_page(profile_url)
    
      hash = {}
      social_links = []
      html = File.read(profile_url)
      student_attributes = Nokogiri::HTML(html)
     
     
     student_attributes.xpath('//div[@class="social-icon-container"]/a').map { |link| social_links << link['href'] }
     social_links.select do |link_with_key|
         if link_with_key.include?('twitter') == true
          hash[:twitter] = link_with_key
         
         elsif link_with_key.include?('linkedin') == true
          hash[:linkedin] = link_with_key
         
         elsif link_with_key.include?('github') == true
          hash[:github] = link_with_key
         
         else 
          hash[:blog] = link_with_key
       end
      end
      
      quote = student_attributes.css("div.profile-quote").text
      hash[:profile_quote] = quote
      
      student_bio = student_attributes.css("div.description-holder p").text
      hash[:bio] = student_bio
      
     
    #end 
    #binding.pry
    return hash
  end

end

