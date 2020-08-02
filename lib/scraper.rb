require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    
    students.each do |student|
      student_hash = {
        :name => student.css(".card-text-container .student-name").text,
        :location => student.css(".card-text-container .student-location").text,
        :profile_url => student.css("a")[0]["href"]
      }
      array << student_hash
    end 
    array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = doc.css(".vitals-container .vitals-text-container")
    links = doc.css(".social-icon-container a")
    profile_hash = {
      :profile_quote => profile.css(".profile-quote").text,
      :bio => doc.css(".details-container .bio-content p").text
    }
    
    ##There must be a cleaner way to set empty hashes to nil or skip missing info
    if links.css("a[href*=twitter]")[0]
        profile_hash[:twitter] = links.css("a[href*=twitter]")[0]['href']
    end
    if links.css("a[href*=linkedin]")[0]
      profile_hash[:linkedin] = links.css("a[href*=linkedin]")[0]['href']
    end 
    if links.css("a[href*=github]")[0]
      profile_hash[:github] = links.css("a[href*=github]")[0]['href']
    end
    if links.css("img").last['src'].include?('rss')
      profile_hash[:blog] = links.css("a").last['href']
    end 
    
    profile_hash
  end

end

