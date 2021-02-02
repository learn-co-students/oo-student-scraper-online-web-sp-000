require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css("div.student-card a")
    profiles = []

    students.each {|student|
      name = student.css("h4").text
      location = student.css("p").text
      url = student.attribute("href").text
      profiles << { name: name, profile_url: url, location: location, }
    }

    profiles

  end

  def self.scrape_profile_page(profile_url)
    prof = Nokogiri::HTML(open(profile_url))

    socials = prof.css("div.social-icon-container a")

    person = {}
    person[:profile_quote] = prof.css("div.profile-quote").text.strip
    person[:bio] = prof.css("div.description-holder p").text.strip

    socials.each {|social|
      val = social.attribute("href").text.strip
      if val.include?("twitter")
        person[:twitter] = val
      elsif val.include?("github")
        person[:github] = val
      elsif val.include?("linked")
        person[:linkedin] = val
      else
        person[:blog] = val
      end
    }

    person
  end

end
