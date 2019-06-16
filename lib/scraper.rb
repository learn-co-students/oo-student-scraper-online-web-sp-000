require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  attr_accessor :students

  def self.scrape_index_page(index_url)
  index_html = open(index_url)
  index_doc = Nokogiri::HTML(index_html)
  student_cards = index_doc.css(".student-card")
  students_array = []
  student_cards.collect do |info|
   students_array << {
     :name => info.css("h4.student-name").text,
     :location => info.css("p.student-location").text,
     :profile_url => info.css("a").attribute('href').value
   }

   end
   students_array
  end

  def self.scrape_profile_page(profile_url)
    profile_html = open(profile_url)
    profile_doc = Nokogiri::HTML(profile_html)
    students_sm = {}
    profile_doc.css("div.social-icon-container a").each do |info|
        case info.attribute("href").value
        when /twitter/
          students_sm[:twitter] = info.attribute("href").value
        when /github/
          students_sm[:github] = info.attribute("href").value
        when /linkedin/
          students_sm[:linkedin] = info.attribute("href").value
        else
          students_sm[:blog] = info.attribute("href").value
      end
    end
 students_sm[:profile_quote] = profile_doc.css("div.profile-quote").text
 students_sm[:bio] = profile_doc.css("div.bio-content div.description-holder").text.strip
 students_sm
end
end
