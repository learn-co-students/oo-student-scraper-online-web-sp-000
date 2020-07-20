require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        name = student.css('.student-name').text
        location = student.css('.student-location').text
        profile_link = "#{student.attr('href')}"
        students_array << {name: name, location: location, profile_url: profile_link}
      end
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    social_media = {}
    doc = Nokogiri::HTML(open(profile_url))


    doc.css(".social-icon-container a").each do |social|
      if social.attribute("href").value.include?("github")
        social_media[:github] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        social_media[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("twitter")
        social_media[:twitter] = social.attribute("href").value
      else
        social_media[:blog] = social.attribute("href").value
      end
    end

    social_media[:profile_quote] = doc.css(".profile-quote").text
    social_media[:bio] = doc.css(".description-holder p").text

    social_media
  end




end


