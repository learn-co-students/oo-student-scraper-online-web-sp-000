require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_page = Nokogiri::HTML(open(index_url))
    students = []
    student_page.css("div.roster-cards-container").each do |info|
      info.css(".student-card a").each do |student|
        hash = {
        :name => student.css('.student-name').text,
        :location => student.css('.student-location').text,
        :profile_url => "#{student.attribute('href')}"
        }
        students << hash
      end
    end
    students 
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_links = profile_page.css(".social-icon-container").children.css("a").map { |x| x.attribute('href').value}
    profile_links.each do |link|
      if link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      elsif link.include?("twitter")
        profile[:twitter] = link
      else
        profile[:blog] = link
      end
    end
    profile[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    profile[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
    profile
  end

end