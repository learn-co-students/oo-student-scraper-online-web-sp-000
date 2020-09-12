require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './student'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    @students = []
    doc.css(".student-card").each do |card|
      name = card.css("h4").text
      location = card.css(".student-location").text
      profile_url = card.css("a").attribute("href").text
      student_hash = {:name=>name, :location=>location, :profile_url=>profile_url}
      @students << student_hash
    end
    @students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    scraped_student = {}
    scraped_student[:profile_quote] = doc.css(".profile-quote").text
    scraped_student[:bio] = doc.css(".description-holder p").text

    doc.css(".social-icon-container a").each do |social|
      if social.attribute("href").value.match?(/twitter/)
        twitter = social.attribute("href").value
        scraped_student[:twitter] = twitter
      elsif social.attribute("href").value.match?(/linkedin/)
        linkedin = social.attribute("href").value
        scraped_student[:linkedin] = linkedin
      elsif social.attribute("href").value.match?(/github/)
        github = social.attribute("href").value
        scraped_student[:github] = github
      else
        blog = social.attribute("href").value
        scraped_student[:blog] = blog
      end
    end

    scraped_student
    # twitter = doc.css(".social-icon-container a")[0].attribute("href").value
    # linkedin = doc.css(".social-icon-container a")[1].attribute("href").value
    # github = doc.css(".social-icon-container a")[2].attribute("href").value
    # blog = doc.css(".social-icon-container a")[3].attribute("href").value

    #profile_hash = {:twitter=>twitter, :linkedin=>linkedin, :github=>github, :blog=>blog, :profile_quote=>profile_quote, :bio=>bio}

  end

end

#Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html")
