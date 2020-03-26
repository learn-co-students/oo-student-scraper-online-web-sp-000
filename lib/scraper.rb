require 'open-uri'
require 'pry'

class Scraper

    # student_card: doc.css("div.student-card")
    # student-name: student_card.css("h4.student-name").first.text
    # student-location: student_card.css("p.student-location").first.text
    # profile_url: student.css("a").attribute("href").value
  
    def self.scrape_index_page(index_url)
      page = Nokogiri::HTML(open(index_url))
      students = []
  
      page.css("div.student-card").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = student.css("a").attribute("href").value
        student_info = {:name => name,
                  :location => location,
                  :profile_url => profile_url}
        students << student_info
        end
      students
    end

    def self.scrape_profile_page(profile_url)
      student = {}
      profile_page = Nokogiri::HTML(open(profile_url))
      links = profile_page.css(".social-icon-container").children.css("a").map {|el| el.attribute('href').value}
      
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
      end
      student[:profile_quote] = profile_page.css(".profile-quote").text
      student[:bio] = profile_page.css("div.description-holder p").text
      student
    end

  end
