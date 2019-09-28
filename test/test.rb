require 'open-uri'
require 'pry'
require 'nokogiri'

doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"))


link_container = doc.css("div.social-icon-container").css("a")
details_container = doc.css("div.details-container")



profile_quote = doc.css("div.profile-quote").text
bio = doc.css("div.description-holder").css("p").text



def self.scrape_profile_page(profile_url)
  doc = Nokogiri::HTML(open(profile_url))
  
end

#this is the end product we are looking for
  # {
  #   :twitter=>"http://twitter.com/flatironschool",
  #   :linkedin=>"https://www.linkedin.com/in/flatironschool",
  #   :github=>"https://github.com/learn-co",
  #   :blog=>"http://flatironschool.com",
  #   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
  #   :bio=> "I'm a school"
  # }
##########