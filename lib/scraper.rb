require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".roster-cards-container").each do |div|
      div.css(".student-card a").each do |info|
        this_profile_url = "#{info.attr('href')}"
        this_location = info.css('.student-location').text
        this_name = info.css('.student-name').text
        student_array << {
          profile_url: this_profile_url,
          name: this_name,
          location: this_location
        }
      end
    end
    #create and return an array of hashes from the elements
    #student_array = {
      ##:name => doc.css(div.card-text-container h4.student-name).text
      ##:location => #doc.location.css,
      ##:profile_url => #doc.profile_url.css
    #}
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student_attributes = {}
    profile = Nokogiri::HTML(open(profile_url))
    #collect all the link hrefs
    links = profile.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    #iterate through all the links that were grabbed
    links.each do |link|
    #case for each link _____
    if link.include?("linkedin")
        student_attributes[:linkedin] = link
      elsif link.include?("github")
        student_attributes[:github] = link
      elsif link.include?("twitter")
        student_attributes[:twitter] = link
      else
        student_attributes[:blog] = link
      end
    #close iteration
  end
    #grab quote if there is one
    student_attributes[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    #grab bio if there is one
    student_attributes[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p")

    student_attributes
  end

end
