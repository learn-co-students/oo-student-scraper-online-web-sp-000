require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url)).css("div.student-card")
    students.map { |student| parse_student_card(student) }
  end

  def self.parse_student_card(student)
    { name: student.css("h4.student-name").text,
      location: student.css("p.student-location").text,
      profile_url: student.css("a").first["href"]
    }
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    profile_data = {
      profile_quote: profile.css("div.profile-quote").text,
      bio: profile.css("div.description-holder > p").text
    }
    profile.css("div.social-icon-container > a").each do |social|
      url = social["href"]
      if url.include?("twitter.com")
        profile_data[:twitter] = url
      elsif  url.include?("linkedin.com")
        profile_data[:linkedin] = url
      elsif  url.include?("github.com")
        profile_data[:github] = url
      else
        profile_data[:blog] = url
      end
    end
    profile_data
  end
end
