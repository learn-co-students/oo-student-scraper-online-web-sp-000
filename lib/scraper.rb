require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    student_array = Array.new
    html = open(index_url)
    source = Nokogiri::HTML(html)
    
    source.css("div.roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each do |student_info|
        student_link = student_info.attr("href")
        student_location = student_info.css(".student-location").text
        student_name = student_info.css(".student-name").text
        student_hash = Hash.new 
        student_hash[:name] = student_name
        student_hash[:location] = student_location
        student_hash[:profile_url] = student_link
        student_array << student_hash
      end       
    end 
   student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    source = Nokogiri::HTML(html)
    student_hash = Hash.new 

    source.css("div.vitals-container").each do |student_info|
      links = student_info.css(".social-icon-container").children.css("a").map{|ele| ele.attr("href")}
      quote = student_info.css("div.vitals-text-container").css("div.profile-quote").text
        
      links.each do |link|
          if link.include?("twitter")
            student_hash[:twitter] = link
          elsif link.include?("linkedin")
            student_hash[:linkedin] = link
          elsif link.include?("github")
            student_hash[:github] = link
          else 
            student_hash[:blog] = link 
          end 
        end 
      student_hash[:profile_quote] = quote
    end 

    source.css("div.details-container").each do |details|
      bio = details.children.css("div")[3].children.text.strip
      student_hash[:bio] = bio
    end 
      student_hash
      #  binding.pry
  end

end

