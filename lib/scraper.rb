require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    student_info_card = doc.css("div .student-card")
    
    student_info_card.collect do |attributes|
      {:name => attributes.css("h4").text,
        :location => attributes.css("p").text,
        :profile_url => attributes.css("a").attr("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_links = doc.css("div .social-icon-container a")
    info_hash = {}
    
    # binding.pry
    social_links.each do |element|
      if element.attr("href").include?("twitter")
          info_hash[:twitter] = element.attr("href")
        elsif element.attr("href").include?("linkedin")
          info_hash[:linkedin] = element.attr("href")
        elsif element.attr("href").include?("github")
          info_hash[:github] = element.attr("href")
        elsif element.attr("href").end_with?("com/")
          info_hash[:blog] = element.attr("href")
        end
      end
    
    info_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text.gsub("\n", "").split.join(" ")
    info_hash[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text.gsub("\n", "").split.join(" ")
    
    info_hash
  end

end

#div .description-holder
#profile quote
#bio


#all info - div class student-card
# name - div card-text-container -> h4 class student-name
#location - div card-text-container -> p class student-location
#profile url - a href