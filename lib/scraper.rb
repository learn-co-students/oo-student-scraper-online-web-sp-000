require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    site = Nokogiri::HTML(open(index_url))

    students = []
      site.css("div.student-card").each do |student|
        students << {
          :name => student.css("h4.student-name").text,
          :location => student.css("p.student-location").text,
          :profile_url => student.css("a").attribute("href").value
          } 
      end
    students
  end

  def self.scrape_profile_page(profile_url)

    profile = Nokogiri::HTML(open(profile_url))

    student = {}

    social_media = profile.css("div.social-icon-container a").collect {|s| s.attribute("href").value}

    social_media.each do |sm|
      if sm.include?("twitter")
        student[:twitter] = sm
      elsif sm.include?("linkedin")
        student[:linkedin] = sm
      elsif sm.include?("github")
        student[:github] = sm
      else
        student[:blog] = sm
      end
    end

    student[:profile_quote] = profile.css("div.profile-quote").text

    student[:bio] = profile.css("div.description-holder p").text

    student
  end

end

# social link - profile.css("div.social-icon-container a").attribute("href").value
# social image link - profile.css("div.social-icon-container a img").attribute("src").value