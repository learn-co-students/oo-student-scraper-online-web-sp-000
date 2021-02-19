require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

# return an array of hashes, one for each student
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    doc.css(".student-card").map do |student|
      name = student.css("h4").text
      url = student.css("a/@href").text
      location = student.css("p").text
      {name: name, profile_url: url, location: location}
    end
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social = doc.css(".social-icon-container")
    profile = {}
    #create an array of urls to iterate over
    urls = doc.css(".social-icon-container").css("a/@href").text.split("http")
    urls.each do |i|
      if i.include?("twitter")
        profile[:twitter] = "http" + urls.detect {|i| i.include?("twitter")}
      end
      if i.include?("linkedin")
        profile[:linkedin] = "http" + urls.detect {|i| i.include?("linkedin")}
      end
      if i.include?("github")
        profile[:github] = "http" + urls.detect {|i| i.include?("github")}
      end
    end

    if doc.css(".social-icon-container").css("a/@href")[3]
      profile[:blog] = doc.css(".social-icon-container").css("a/@href")[3].text
    end

    profile[:bio] = doc.css(".description-holder").css("p").text if doc.css(".description-holder").css("p")
    profile[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")

    profile

  end

end
