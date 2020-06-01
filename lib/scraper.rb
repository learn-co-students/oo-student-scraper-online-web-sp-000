require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url) #array of hashes
    scraped_students = Nokogiri::HTML(open(index_url))

    students = []

      scraped_students.css("div.student-card").each do |student|
        name = student.css("h4.student-name").text
        location = student.css("p.student-location").text
        profile_url = student.css("a").attribute("href").value

        student_info = {
          :name => name,
          :location => location,
          :profile_url => profile_url
        }
        students << student_info
      end
      students
    end


  def self.scrape_profile_page(profile_url) #hash of each student's social media addresses
    # can handle profile pages w/out all the social links
    #profile_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"
        page = Nokogiri::HTML(open(profile_url))

      student_data = {}

      social_data = page.css(".social-icon-container").children.css("a").collect {|social|
      social.attribute("href").value}

      social_data.each do |address|
        if address.include?("twitter")
          student_data[:twitter] = address
        elsif address.include?("linkedin")
            student_data[:linkedin] = address
        elsif address.include?("github")
            student_data[:github] = address
        else address.include?("blog")
            student_data[:blog] = address
        end
          student_data[:profile_quote] = page.css("div.profile-quote").text
          student_data[:bio] = page.css("div.description-holder p").text
        end
          student_data
    end
end
