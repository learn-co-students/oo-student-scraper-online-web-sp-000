require 'open-uri'
require 'pry'

#In this lab, you'll be scraping your Learn.co student website. You'll use the index page to grab a list of
#current students and instantiate a series of Student objects. You'll scrape the individual profile pages of each
#student to add attributes to each individual student.

class Scraper
  #is a class method that scrapes the student index page ('./fixtures/student-site/index.html')
  #and a returns an array of hashes in which each hash represents one student
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|     #parse through each container
      card.css(".student-card a").each do |student|                 #parse through each student in card
        name = student.css('.student-name').text                      #grab name
        location = student.css('.student-location').text              #grab location
        profile_link = "#{student.attr('href')}"                      #grab link
        students << {name: name, location: location, profile_url: profile_link}
      end
    end
    return students
  end

  def self.scrape_profile_page(profile_url)
   student_profiles = {}                              #declare Hash
   html = open(profile_url)
   profile = Nokogiri::HTML(html)                     #alternate way of initializing Nokogiri

   profile.css("div.main-wrapper.profile .social-icon-container a").each do |social_media|      #iterate over the main-wrapper/ social-icon css class fields
     if social_media.attribute("href").value.include?("twitter")                                #if the href attribute includes these values,
       student_profiles[:twitter] = social_media.attribute("href").value                        #Assign the symbol :twitter to the value of attribute
     elsif social_media.attribute("href").value.include?("linkedin")
       student_profiles[:linkedin] = social_media.attribute("href").value                       #syntax for adding to Hash
     elsif social_media.attribute("href").value.include?("github")
       student_profiles[:github] = social_media.attribute("href").value
     else
       student_profiles[:blog] = social_media.attribute("href").value
     end
   end

   student_profiles[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
   student_profiles[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text

   return student_profiles              #return our hash
  end
end
