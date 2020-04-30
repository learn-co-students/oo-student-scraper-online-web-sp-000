require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_scraper = Nokogiri::HTML(html)

    student_array = []
    student_profiles = index_scraper.css('div.student-card')
    student_profiles.each do |student_profile|
      student_hash = {
        :name => student_profile.css('h4.student-name').text,
        :location => student_profile.css('p.student-location').text,
        :profile_url => student_profile.css('a').attribute('href').value
      }
      student_array << student_hash
    end
    student_array
  end



  def self.scrape_profile_page(profile_url)
      html = open(profile_url)
      doc = Nokogiri::HTML(html)

      student_profiles = {}

      social_link = doc.css(".vitals-container .social-icon-container a")

      social_link.each do |element|
        if element.attr("href").include?("twitter")
          student_profiles[:twitter] = element.attr('href')
        elsif element.attr("href").include?("linkedin")
          student_profiles[:linkedin] = element.attr("href")
        elsif element.attr("href").include?("github")
          student_profiles[:github] = element.attr("href")
        elsif element.attr("href").include?("com/")
        student_profiles[:blog] = element.attr("href")
        end
      end

      student_profiles[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      student_profiles[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text

      student_profiles
    end
end
