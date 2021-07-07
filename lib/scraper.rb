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

      student_hash = {:name => student_name, :location => student_location, :profile_url => student_profile_url}
      students << student_hash
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    # create a container to for Nokogiri to work
    # Nokogiri::HTML(open(url))
    # create a empty hash
    # create a container to house the doc container with the information on social media
    # the doc container need to iterate through the social-icon-container class to get all the media information
    # use .attribute().value, can  be done with one line
    # now iterate through the new countainer to assign the information to keys
    # since not all profiles have all the information platforms use if, elsif and else to see if there's info there
    # if there is create a key and assign the key's value to the iteration argument
    # since there are only four possibilities the blog which is the rarest can be put in an else block
    # now you can close the loop and assign key/values to quote and bio
    # return the hash

    doc = Nokogiri::HTML(open(profile_url))
    student = {}

    student_social_media = doc.css("div.social-icon-container a").collect {|icon| icon.attribute("href").value}
    student_social_media.each do |media_link|
      if media_link.include?("twitter")
        student[:twitter] = media_link
      elsif media_link.include?("linkedin")
        student[:linkedin] = media_link
      elsif media_link.include?("github")
        student[:github] = media_link
      else
        student[:blog] = media_link
      end
    end
    student[:bio] = doc.css("div.description-holder p").text
    student[:profile_quote] = doc.css("div.profile-quote").text
    student

  end


end
