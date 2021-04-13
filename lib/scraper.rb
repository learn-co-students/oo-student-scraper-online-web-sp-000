require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []

    # page.css("div.roster-cards-container").each do |card|
      index_page.css("div.student-card").each do |student|     #"div.student-card" obtained from website

        students << {
          :name => student.css('.student-name').text,
          :location => student.css('.student-location').text,
          :profile_url => student.css("a").attr('href').value
        }
      end
    students
  end


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    individual_student = {}

    social_link = profile_page.css("div.social-icon-container").css("a").collect {|s| s.attribute("href").value}
    social_link.each do |link|
      if link.include?("linkedin")
        individual_student[:linkedin] = link
      elsif link.include?("twitter")
        individual_student[:twitter] = link
      elsif link.include?("github")
        individual_student[:github] = link
      else
        individual_student[:blog] = link
      end
    end
      individual_student[:bio] = profile_page.css(".description-holder").css("p").text
      individual_student[:profile_quote] = profile_page.css(".profile-quote").text
      individual_student
  end

end
