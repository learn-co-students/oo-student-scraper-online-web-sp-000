require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

#page.css(".student-card")


  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    student_collection = []
    page.css(".student-card").each do |student|
      current_student = {}
      current_student[:name] = student.css(".student-name").text
      current_student[:location] = student.css(".student-location").text
      current_student[:profile_url] = student.css("a").first["href"]
      # binding.pry
      student_collection << current_student
    end
    student_collection


  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    output_hash = {}
    page.css(".social-icon-container").css("a").each do |a|
      if /twitter/ =~ a["href"]
        output_hash[:twitter] = a["href"]
      elsif /linkedin/ =~ a["href"]
        output_hash[:linkedin] = a["href"]
      elsif /github/ =~ a["href"]
        output_hash[:github] = a["href"]
      else
        output_hash[:blog] = a["href"]
      end
    end

    if page.css(".profile-quote")
      output_hash[:profile_quote] = page.css(".profile-quote").text
    end

    if page.css(".description-holder")
      output_hash[:bio] = page.css(".description-holder").css("p").text
    end
    output_hash
  end


end


# Scraper.scrape_index_page("./fixtures/student-site/index.html")
