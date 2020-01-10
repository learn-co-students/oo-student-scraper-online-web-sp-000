require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # create a container to for Nokogiri to work
    # Nokogiri::HTML(open(url))
    # create a empty array
    # iterate through the student-card class to get the students name, location and profile url
    # create variables to house information and use .text for name and location since they have just text information
    # create variables to house information and use .attribute().value for profile url since its a HTML link
    # create a hash and assign keys and put the values as the variables created before
    # put the hash inside the array
    # return the array

    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css("div.student-card").collect do |student|
      student_name = student.css("h4.student-name").text
      student_location = student.css("p.student-location").text
      student_profile_url = student.css("a").attribute("href").value

      student_hash = {:name => student_name, :location => student_location, :profile_url = student_profile_url}
      students << student_hash
    end
    students
  end



  end

  def self.scrape_profile_page(profile_url)


  end


end

# create a container for Nokogiri to work
# Nokogiri::HTML(open(desired url))
# create a empty array
# use nokogiri's method css to scrape the class that holds all the information
# iterate through that class
# assign a variable to hold the class that holds name,location and profile url
# since name and location is just text use text to get the values
# profile url is an html link so text doesn't work you have to uses attribute and value
# create a hash and assign the variables to it, keys are symbols
# put the hash in the array
# return the array
#
# doc = Nokogiri::HTML(open(index_url))
#
# students = []
#
# doc.css("div.student-card").collect do |student|
#   student_name = student.css("h4.student-name").text
#   student_location = student.css("p.student-location").text
#   student_profile_url = student.css("a").attribute("href").value
#
#   student_hash = {:name => student_name, :location => student_location, :profile_url => student_profile_url}
#   students << student_hash
# end
# students

# create a container for Nokogiri to work
# Nokogiri::HTML(open(desired url))
# create a hash
# create a countainer variable to hold the social icons class and iterate through the class to get the social icons
# since the social icons are links use attribute and value methods
# iterate through the countainer to assign values to keys for the hash
# but since not all profiles have all the desired icons, uses if,elsifs and else
# look to see if the parameter has the link in it with include?
# if its not a twitter,github or linkedin it has to be a blog
# assign the rest of stuff as symbols
# return the hash

# doc = Nokogiri::HTML(open(profile_url))
#
# student = {}
#
# social_media_container = doc.css("div.social-icon-container a").collect {|icon| icon.attribute("href").value}
# social_media_container.each do |media_link|
#   if media_link.include?("twitter")
#     student[:twitter] = media_link
#   elsif media_link.include?("linkedin")
#     student[:linkedin] = media_link
#   elsif media_link.include?("github")
#     student[:github] = media_link
#   else
#     student[:blog] = media_link
#   end
# end
# student[:bio] = doc.css("div.description-holder p").text
# student[:profile_quote] = doc.css("div.profile-quote").text
# student
