require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    #loading the HTML element using Nokogiri and storing in a 'doc' variable
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    #iterate over each student card and collect array of hashes
    doc.css(".student-card").collect {|student| {name: student.css(".student-name").text, location: student.css(".student-location").text, profile_url: student.css("a").attr("href").text}}
  end

  def self.scrape_profile_page(profile_url)
    #loading the HTML elements of the profile page using Nokogiri
    doc = Nokogiri::HTML(open(profile_url))

    #establish the expected social media sites to be linked
    social_med_arr = ["twitter","linkedin","github"]

    #setting an empty hash to have elements loaded into
    return_hash = {}

    #using Nokogiri css selector to parse for any potential social media elements
    social_media = doc.css(".social-icon-container").css("a")

    #looping through the array, using regex to parse the type of social media based on url, using gsub to get rid of 'www.' as the regex captures strings in between '//' and '.'
    social_media.each do |social|
      social_med = social.attr("href").gsub("www.","")[/(?<=\/{2})(.*?)(?=\.)/]
      #the regex above fails for blog posts because the site is named after a student, using an if/else expression to see if the parsed social media is part of the social_med_arr, if not then setting the key to 'blog'
      if social_med_arr.include?(social_med)
        return_hash[social_med.to_sym] = social.attr("href")
      else
        return_hash[:blog] = social.attr("href")
      end
    end

    #adding the profile_quote and bio keys to the hash
    return_hash[:profile_quote] = doc.css(".vitals-text-container").css(".profile-quote").text
    return_hash[:bio] = doc.css(".description-holder").css("p").text

    #returning the final hash
    return_hash
  end

end
