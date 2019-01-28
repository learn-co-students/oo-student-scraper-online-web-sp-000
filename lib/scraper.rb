require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    html = File.read(index_url)
    index = Nokogiri::HTML(html)
    index.css(".student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      url = "students/#{name.downcase.split.join("-")}.html"
      student = {name: name, location: location, profile_url: url}
      student_array << student
    end
    
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    social_medias = ["github", "twitter", "linkedin"]
    
    html = File.read(profile_url)
    index = Nokogiri::HTML(html)
    
    index.css(".social-icon-container").xpath("//div/a/@href").each do |social|
      social_medias.each do |social_media|
        if social.value.include?(social_media)
          student[social_media.to_sym] = social.value
        else
          student[:blog] = social.value unless social_medias.any? {|s| social.value.include?(s)}
        end
      end
    end
      
    student[:profile_quote] = index.css(".profile-quote").text
    student[:bio] = index.css(".description-holder p").text
    
    student
  end

end

