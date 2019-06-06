require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    student_hash = []

    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_hash << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "#{student.attr("href")}"
        }
      end
    end
    student_hash
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    attribute_hash = {}

    social_icon = doc.css("div.social-icon-container a").collect {|x| x.attribute("href").value}

    social_icon.each do |link|
      if link.include?("linkedin")
        attribute_hash[:linkedin] = link
      elsif link.include?("github")
        attribute_hash[:github] = link
      elsif link.include?("twitter")
        attribute_hash[:twitter] = link
      elsif link.include?(".com")
        attribute_hash[:blog] = link
      end
  #attribute_hash[:linkedin] = link if link.include?("linkedin")
  #attribute_hash[:github] = link if link.include?("github")
# attribute_hash[:twitter] = link if link.include?("twitter")
 binding.pry
#  attribute_hash[:blog] = link if link.include?(".com") #why can't this handle profiles with outthe links
    end

    attribute_hash[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text

    attribute_hash[:profile_quote] = doc.css(".profile-quote").text

    attribute_hash
  end

end
