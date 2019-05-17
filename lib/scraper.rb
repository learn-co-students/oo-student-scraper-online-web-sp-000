require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(File.read(index_url))
    scraped_students = []
    page.css(".student-card a").each do |student|
      scraped_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.attribute("href").value
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(File.read(profile_url))
    scraped_student = {
      :bio => profile.css("div.description-holder").css("p").text,
      :profile_quote => profile.css("div.profile-quote").text
    }
    profile.css("div.social-icon-container a").each do |container|
      url = container.attribute("href").value
      case
      when url.include?("twitter")
        scraped_student[:twitter] = url
      when url.include?("linkedin")
        scraped_student[:linkedin] = url
      when url.include?("github")
        scraped_student[:github] = url
      else
        scraped_student[:blog] = url
      end
    end
    scraped_student
  end

end
