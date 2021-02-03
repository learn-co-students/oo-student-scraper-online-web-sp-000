require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)

    students = []

    # name: student.css("a .card-text-container h4").text
    # location: student.css("a .card-text-container p").text
    # profile url: student.css("a").attribute("href").text
    
    web_page = Nokogiri::HTML(open(index_url))
    web_page.css(".student-card").each do |student|
      person = {
        :name => student.css("a .card-text-container h4").text,
        :location => student.css("a .card-text-container p").text,
        :profile_url => student.css("a").attribute("href").text
      }
      students << person
    end
    students
  end

  def self.scrape_profile_page(profile_url)

    prof_page = Nokogiri::HTML(open(profile_url))
    social_links = prof_page.css(".social-icon-container a").collect do |app|
      app.attribute("href").value  
    end
    @socials = {
      :profile_quote => prof_page.css(".profile-quote").text,
      :bio => prof_page.css(".description-holder p").text
    }

    social_links.each do |link|
      if link.include?("twitter")
        @socials[:twitter] = link 
      elsif link.include?("linkedin")
        @socials[:linkedin] = link
      elsif link.include?("github")
        @socials[:github] = link 
      else
        @socials[:blog] = link
      end
    end
    @socials
  end

end

