require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  attr_accessor :student

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_list = []
    doc.css("div.student-card").each do |s|
      student_list << {
        :name => s.css("h4").text,
        :location => s.css("p").text,
        :profile_url => s.css("a").attribute("href").value
      }
    end
    student_list    
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_attr = {}
    social_media_total = doc.css("div.social-icon-container a").collect {|i| i.attribute("href").value}
    social_media_total.each do |social_media_indiv|
      if social_media_indiv.include?("twitter")
        student_attr[:twitter] = social_media_indiv
      elsif social_media_indiv.include?("github")
        student_attr[:github] = social_media_indiv
      elsif social_media_indiv.include?("linkedin")
        student_attr[:linkedin] = social_media_indiv
      else
        student_attr[:blog] = social_media_indiv
      end
    end
    student_attr[:bio] = doc.css("div.bio-content p").text
    student_attr[:profile_quote] = doc.css("div.profile-quote").text
    student_attr
  end

end
