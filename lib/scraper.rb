require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
      
    students = []
      # page.css(".student-card")
      page.css(".student-card").each do |student|
    #  binding.pry
      name_ = student.css("h4").text
      location_ = student.css("p").text
      profile_url_ = student.css("a").attr("href").value

      students << {name: name_, location: location_, profile_url: profile_url_ }
      
      end
      students

  end

  def self.scrape_profile_page(profile_url)
    student = {}
    student_profile = Nokogiri::HTML(open(profile_url))
    # binding.pry
    twitter = ""
    linkedin = ""
    github = ""

      # binding.pry

      links = student_profile.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
      links.each do |link|

      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
      # binding.pry
    end
    student[:profile_quote] = student_profile.css(".profile-quote").text if student_profile.css(".profile-quote")
    student[:bio] = student_profile.css("div.bio-content.content-holder div.description-holder p").text if student_profile.css("div.bio-content.content-holder div.description-holder p")
  
      student

  end


end

 # student_profile.css(".social-icon-container").each do |profile|


      # if profile.css("a").attr("href").value.include? ("twitter")
      #   student[:twitter] = profile.css("a").attr("href").value
      # elsif profile.css("a").attr("href").value.include? ("linkedin")
      #   student[:linkedin] = profile.css("a").attr("href").value
      #   # binding.pry
      # elsif profile.css("a").attr("href").value.include? ("github")
      #   student[:github] = profile.css("a").attr("href").value

      # end
    # end
    # student
    # binding.pry