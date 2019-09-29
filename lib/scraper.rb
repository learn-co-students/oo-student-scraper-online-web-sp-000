require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor :students_list, :doc

  def self.scrape_index_page(index_url)
    @doc = Nokogiri::HTML(open(index_url))
    student_cards = @doc.css("div[class='student-card']").css("a")
    @students_list = []
    student_cards.each do |i|
      student_hash = {
        :name => i.css("div[class='card-text-container']").css("div").css("h4").text,
        :location => i.css("div[class='card-text-container']").css("div").css("p").text, 
        :profile_url => i.attribute("href").value
      }
      @students_list << student_hash
    end
    @students_list
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css("div.social-icon-container").css("a")             #loop through each link to see if value contains currentlinks.
    returnable_hash = {}
    links.each do |link|
      if link.attribute("href").value.include?("twitter")
        returnable_hash[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin")
        returnable_hash[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github")
        returnable_hash[:github] = link.attribute("href").value
      elsif link.attribute("href").value.include?("youtube")
        returnable_hash[:youtube] = link.attribute("href").value
      else
        returnable_hash[:blog] = link.attribute("href").value
      end
    end
    returnable_hash[:profile_quote] = doc.css("div.profile-quote").text
    returnable_hash[:bio] = doc.css("div.description-holder").css("p").text
    returnable_hash
  end

end

  