require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(File.read(index_url))
    students = []
    doc.css("div.student-card").each do |card|
      students << {
        :name => card.css("h4").text,
        :location => card.css("p").text,
        :profile_url => card.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(File.read(profile_url))
    info = {
      :bio => doc.css("div.description-holder").css("p").text,
      :profile_quote => doc.css("div.profile-quote").text
    }
    doc.css("div.social-icon-container a").each do |container|
      url = container.attribute("href").value
      case
      when url.include?("twitter")
        info[:twitter] = url
      when url.include?("linkedin")
        info[:linkedin] = url
      when url.include?("github")
        info[:github] = url
      else
        info[:blog] = url
      end
    end
    info
  end
end
