require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_card = doc.css('div.student-card')
    student_infos_array = []
    
    student_card.each do |card|
      student_info_hash = { 
        name: card.css('h4.student-name').text,
        location: card.css('p.student-location').text,
        profile_url: card.css('a').attribute("href").value
      }
      
      student_infos_array << student_info_hash
    end
    student_infos_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student = {}
    
    container = doc.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      container.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
        end
      end
      student[:profile_quote] = doc.css("div.profile-quote").text
      student[:bio] = doc.css("div.description-holder p").text
      student
  end

end

