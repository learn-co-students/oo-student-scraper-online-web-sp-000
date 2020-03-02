require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    #index_url = https://learn-co-curriculum.github.io/student-scraper-test-page/index.html
    scraped_array = Nokogiri::HTML(open(index_url))
    scraped_students = []

    scraped_array.css("div.student-card").each do |person|

        scraped_student = {
                    :name => person.css(".student-name").text,
                    :location => person.css(".student-location").text,
                    :profile_url => person.css("a").attribute("href").value
                          }

        scraped_students << scraped_student

    end
      scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_profile_array = Nokogiri::HTML(open(profile_url))
    students = {}
    student = {}

    url_array = scraped_profile_array.css(".social-icon-container a")
    url_array.each do |element|
        #:name => element.css("card-text-container student-name").text,
            if element.css("img").attribute("src").value.include?("twitter")
                student[:twitter] = element.attribute("href").value
            elsif element.css("img").attribute("src").value.include?("linkedin")
                student[:linkedin] = element.attribute("href").value
            elsif element.css("img").attribute("src").value.include?("github")
                student[:github] = element.attribute("href").value
            elsif element.css("img").attribute("src").value.include?("youtube")
                student[:youtube] = element.attribute("href").value
            elsif element.css("img").attribute("src").value.include?("rss")
                student[:blog] = element.attribute("href").value
            end
    end


    student[:profile_quote] = scraped_profile_array.css(".profile-quote").text
    student[:bio] = scraped_profile_array.css("div.description-holder p").text

    student
  end

end
