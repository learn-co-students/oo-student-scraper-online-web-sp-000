require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
     doc=Nokogiri::HTML(open(index_url))
     array=[]

     doc.css(".student-card").each do |a|
         student={}
         student[:name]=a.css("h4").text
         student[:location]=a.css("p").text
         student[:profile_url]=a.css("a")[0]['href']
         array<<student
      end
      array
  end

  def self.scrape_profile_page(profile_url)
    doc=Nokogiri::HTML(open(profile_url))
    student_hash={}
    student_hash[:profile_quote]=doc.css(".vitals-text-container .profile-quote").text
    student_hash[:bio]=doc.css(".description-holder p").text

    social_medias=doc.css(".social-icon-container").css("a")
    social_medias.each do |s|
      if s["href"].include?("twitter")
        student_hash[:twitter]=s["href"]
      elsif s["href"].include?("facebook")
          student_hash[:facebook]=s["href"]
        elsif  s["href"].include?("linkedin")
            student_hash[:linkedin]=s["href"]
          elsif  s["href"].include?("github")
              student_hash[:github]=s["href"]
            else student_hash[:blog]=s["href"]
            end
          end
       student_hash
  end

end
