require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    doc = Nokogiri::HTML(open(index_url))
      doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = student.attr('href')
      array << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    array
  end
  

  def self.scrape_profile_page(profile_url)
    hash = {}
    doc = Nokogiri::HTML(open(profile_url))
      hash[:bio] = doc.css(".description-holder p").text
      hash[:profile_quote] = doc.css(".profile-quote").text
    links = doc.css(".social-icon-container").css("a")
      links.each do |link|
        if link.attr("href").include?("twitter")
          hash[:twitter] = link.attr("href")
        elsif link.attr("href").include?("linkedin")
          hash[:linkedin] = link.attr("href")
        elsif link.attr("href").include?("github")
          hash[:github] = link.attr("href")
        else
          hash[:blog] = link.attr("href")
        end
      end
      hash
    end

end
    
    
      #attr is used to get ATTRIBUTES off of the html element
              #when you're working with an object that represents a single html element like that, you can drill into its html attributes with that method


