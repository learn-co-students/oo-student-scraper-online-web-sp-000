require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  def self.scrape_index_page(index_url)
    url = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    index_url = url.css(".student-card a")
    index_url.map do |index|
    index_hash = {:name => index.css('h4').text.strip, :location => index.css('p').text.strip, :profile_url => index['href']}
    index_hash
    end
   #binding.pry
  end

  def self.scrape_profile_page(profile_url)
        page = Nokogiri::HTML(open(profile_url))
        student = {}

        # student[:profile_quote] = page.css(".profile-quote")
        # student[:bio] = page.css("div.description-holder p")
        container = page.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
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
        student[:profile_quote] = page.css(".profile-quote").text
        student[:bio] = page.css("div.description-holder p").text
        student
    end

  end
