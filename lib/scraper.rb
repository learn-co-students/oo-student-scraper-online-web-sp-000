require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(File.read(index_url))
    # doc.css("div.roster-cards-container").css("h4").each do |name|
    students = Array.new(doc.css("h4").count)
    for i in (0...doc.css("h4").count)
      students[i] = {
        name: doc.css("h4")[i].text,
        location: doc.css("p")[i].text,
        profile_url: doc.css("div.student-card a")[i]["href"]
        }
    end

    students
    # both name and location doc.css("div.card-text-container").first.text
    # name only: doc.css("h4").first.text
    # location only: doc.css("p").first.text
    # link only: doc.css("div.student-card a").first["href"]
  end

  def self.scrape_profile_page(profile_url)
  #  profile_url = fixtures/student-site/students/ryan-johnson.html
    doc = Nokogiri::HTML(File.read(profile_url))
    info = {}


    available_info = {}
    doc.css("div.social-icon-container a").each do |object|
      link = object["href"]
      if link.include?("twitter")
        available_info[:twitter] = link
      elsif link.include?("linkedin")
        available_info[:linkedin] = link
      elsif link.include?("github")
        available_info[:github] = link
      else
        available_info[:blog] = link
      end
    end

    available_info[:profile_quote] = doc.css("div.profile-quote").text
    available_info[:bio] = doc.css("div.description-holder p").text

    available_info


  end

end


#ruby lib/scraper.rb
