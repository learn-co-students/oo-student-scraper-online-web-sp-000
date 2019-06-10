require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_index_array = []

    doc.css(".student-card").each do |student|
      student_index_array << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    student_index_array
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html) 
    
     array = []

    student_hash = {}
    

doc.css(".main-wrapper div.social-icon-container a").each do |link|
array << link.attribute("href").value
#    binding.pry

end
array  


#:twitter => array[0] 
    
#[1] pry(Scraper)> array
#=> ["https://twitter.com/jmburges"]    
    
    
    
    
    
#  doc.css(".main-wrapper").each do |student|
    
#      student_hash = {
#        :twitter => student.css(".vitals-container a").attribute("href").value,
#        :linkedin => student.css(".vitals-container a").attribute("href").value,
#        :github => student.css(".vitals-container a").attribute("href").value,
#        :blog => student.css(".vitals-container a").attribute("href").value,
       
       
 #       :profile_quote => student.css(".vitals-text-container div.profile-quote").text,
#        :bio => student.css(".details-container p").text

#      }
#    end
#student_hash
  end

end

=begin

=end