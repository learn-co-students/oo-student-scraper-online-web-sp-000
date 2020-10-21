require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
      students = []

      doc.css('div.student-card').each do |roster|
        students << {
          :name => roster.css('h4.student-name').text,
          :location => roster.css('p.student-location').text,
          :profile_url => roster.css("a").attribute("href").value
          }
      end
      students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
      student_info = {}
        links = doc.css("div.social-icon-container a").map {|socials| socials.attribute("href").value}
        links.each do |link|
        if link.include?("twitter")
          student_info[:twitter] = link
        elsif link.include?("linkedin")
          student_info[:linkedin] = link
        elsif link.include?("github")
          student_info[:github] = link
        else
          student_info[:blog] = link
        end
        end
          student_info[:profile_quote] = doc.css("div.profile-quote").text
          student_info[:bio] = doc.css("div.bio-content.content-holder p").text
      student_info
    end

end
