require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    webpage = open(index_url)
    studentArray = []
    studentDoc = Nokogiri::HTML(webpage)
    studentCards = studentDoc.css("div.roster-cards-container a")
    studentCards.each do | selectedCard |
      link = selectedCard.attr("href")
      name = selectedCard.css(".student-name").text
      location = selectedCard.css(".student-location").text
      tempStudent = {name: name, location: location, profile_url: link}
      studentArray << tempStudent
    #  binding.pry
    end
    return studentArray
  end

  def self.scrape_profile_page(profile_url)
    webpage = open(profile_url)
    # We need... twitter:, linkedin:, github:, blog:, profile_quote:, and bio:
    studentDoc = Nokogiri::HTML(webpage)
    profile_quote = studentDoc.css(".profile-quote").text
    bio = studentDoc.css("div.details-container .bio-content.content-holder .description-holder p").text
    socialHandles = studentDoc.css(".social-icon-container a")
    rHash = {bio: bio, profile_quote: profile_quote}
    socialHandles.each do | selectedLink |
      if (selectedLink.attr("href").include?('twitter'))
        twitter = selectedLink.attr("href")
        rHash[:twitter] = twitter
      elsif (selectedLink.attr("href").include?('linked'))
        linkedin = selectedLink.attr("href")
        rHash[:linkedin] = linkedin
      elsif (selectedLink.attr("href").include?('github'))
        github = selectedLink.attr("href")
        rHash[:github] = github
      elsif (selectedLink.attr("href").include?('http://'))
        blog = selectedLink.attr("href")
        rHash[:blog] = blog
      end
    end
    return rHash
  end

end
