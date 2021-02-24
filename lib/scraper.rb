require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    #set initial values
    student_array = []
    student_hash = {}

    #use nokigiri to get website text
    doc = Nokogiri::HTML(open(index_url))

    #loop through the student-cards
    doc.css(".student-card").each do |x|
      #create the hash
      student_hash = {
            :name => x.css("h4").text,
            :location => x.css("p").text,
            :profile_url => x.children[1].attr("href")
          }
      #send to array
      student_array << student_hash
    end
    #returns array
    student_array
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}

    doc = Nokogiri::HTML(open(profile_url))

    #reads the actual .social-icon-container link and assigns the correct hash or not assign a hash if link is missing
    #children 1,3,5,7 are the ones that were found to contain the links we wanted
    [1,3,5,7].each do |x|
      link = doc.css(".social-icon-container").children[x]
      if link.to_s.include? "twitter"
        profile_hash[:twitter] = doc.css(".social-icon-container").children[x].attr("href")
      end
      if link.to_s.include? "linkedin"
        profile_hash[:linkedin] = doc.css(".social-icon-container").children[x].attr("href")
      end
      if link.to_s.include? "github"
        profile_hash[:github] = doc.css(".social-icon-container").children[x].attr("href")
      end
      #binding.pry
      if link.to_s.include? "rss-icon"
        profile_hash[:blog] = doc.css(".social-icon-container").children[x].attr("href")
      end
    end
    profile_hash[:bio] = doc.css(".description-holder").children[1].text
    profile_hash[:profile_quote] = doc.css(".profile-quote").text

    profile_hash
  end

end
