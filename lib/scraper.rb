require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    new_array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".roster-cards-container").each do |student|
      student.css(".student-card a").each do |value|
        profile_url = value.attr("href")
        name = value.css(".student-name").text
       location = value.css(".student-location").text
      new_array << { name: name, location: location, profile_url: profile_url}
    end
    end 
    new_array
  end

  def self.scrape_profile_page(profile_url)
    new_hash = {}
    new_array = []
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    doc.css(".social-icon-container").children.css("a").each do |value|
      url = value.attribute("href")
      new_array << url.value  
    end 
    new_array.each do |value|
      if value.include?("twitter")
       new_hash[:twitter] = value
       elsif value.include?("linkedin")
        new_hash[:linkedin] = value 
       elsif value.include?("github")
        new_hash[:github] = value
      elsif value.include?("joemburgess")
        new_hash[:blog] = value
        end 
    quote = doc.css(".profile-quote").text
       new_hash[:profile_quote] = quote
       bio = doc.css(".bio-content.content-holder p").text
       new_hash[:bio] = bio
  end
   new_hash
  end

end

