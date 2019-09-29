require 'open-uri'
require 'pry'
require 'nokogiri'

url = "https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"
doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"))


# details_container = doc.css("div.details-container")
# social_container = doc.css("div.social-icon-container").attribute("href").value



# profile_quote = doc.css("div.description-holder").css("p").text
# bio = doc.css("div.description-holder").css("p").text



def scrape_profile_page(profile_url)
  doc = Nokogiri::HTML(open(profile_url))
  links = doc.css("div.social-icon-container").css("a")             #loop through each link to see if value contains currentlinks.
  returnable_hash = {}
  links.each do |link|
    if link.attribute("href").value.include?("twitter")
      returnable_hash(:twitter) = link.attribute("href").value
    elsif link.attribute("href").value.include?("linkedin")
      returnable_hash(:linkedin) = link.attribute("href").value
    elsif link.attribute("href").value.include?("github")
      returnable_hash(:github) = link.attribute("href").value
    elsif link.attribute("href").value.include?("youtube")
      returnable_hash(:youtube) = link.attribute("href").value
    else
      returnable_hash(:blog) = link.attribute("href").value
    end
  returnable_hash(:profile_quote) = doc.css("div.profile-quote").text
  returnable_hash(:bio) = doc.css("div.description-holder").css("p").text
  returnable_hash
end

scrape_profile_page(url)