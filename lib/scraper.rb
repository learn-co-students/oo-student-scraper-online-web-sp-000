require 'open-uri'
require 'pry'
require "nokogiri"

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    list = Nokogiri::HTML(html)

    students = []

    list.css("div.student-card").each do |student|
      students << {
        :name => student.css("a h4.student-name").text,
        :location => student.css("a p.student-location").text,
        :profile_url => student.css("a").attribute('href').value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    list = Nokogiri::HTML(html)
    profile = {}

    list.css("div.social-icon-container a").each do |info|
      if info.attribute("href").value.include?("twitter")
        profile[:twitter] = info.attribute("href").value
      elsif info.attribute("href").value.include?("linkedin")
        profile[:linkedin] = info.attribute("href").value
      elsif info.attribute("href").value.include?("github")
        profile[:github] = info.attribute("href").value
      else
        profile[:blog] = info.attribute("href").value
      end
    end

    profile[:profile_quote] = list.css("div.profile-quote").text
    profile[:bio] =list.css("div.bio-content.content-holder div.description-holder p").text
    profile
  end

end
#students = Scraper.scrape_index_page('fixtures/student-site/index.html')
##Scraper.scrape_profile_page("fixtures/student-site/students/joe-burgess.html")
#binding.pry
