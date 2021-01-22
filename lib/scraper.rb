require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    
    students_array = []

    doc.css(".student-card").each do |student|
      students_array << {
        name: student.css('.student-name').text, 
        location: student.css('.student-location').text,
         profile_url: student.css('a')[0]['href']
        }
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
      attributes_hash = {}
      social_links = doc.css(".social-icon-container").css('a').collect {|e| e.attributes["href"].value}

      social_links.detect do |link|
        attributes_hash[:twitter] = link if link.include?("twitter")
        attributes_hash[:linkedin] = link if link.include?("linkedin")
        attributes_hash[:github] = link if link.include?("github")
      end

        attributes_hash[:blog] = social_links[3] if social_links[3] != nil
        attributes_hash[:profile_quote] = doc.css('.vitals-container .profile-quote').text
        attributes_hash[:bio ]= doc.css('.details-container .description-holder p').text
        attributes_hash
  end

end