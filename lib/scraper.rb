require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    index = Nokogiri::HTML(open(index_url))
  
    index.css(".student-card").collect do |card|
      name = card.css("h4.student-name").text
      location = card.css(".student-location").text
      profile_url = card.css("a").first.attributes["href"].value

      student_hashes = {:name => name, :location => location, :profile_url => profile_url}
    end

  end

  def self.scrape_profile_page(profile_url)
    
    profile = Nokogiri::HTML(open(profile_url))

    student_profile = {}

    student_links = profile.css(".social-icon-container").children.css("a").collect do |profile|
      profile.attribute("href").value
    end

    student_links.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end

    student_profile[:profile_quote] = profile.css(".profile-quote").children.text
    student_profile[:bio] = profile.css(".description-holder").css("p").children.text

    student_profile

  end

end