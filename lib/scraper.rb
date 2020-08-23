require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    #binding.pry

    students_array = []

    doc.css(".student-card").each do |student|
      student_hash = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a/@href").first.value
      }
      students_array << student_hash
    end

    students_array

    # name: doc.css(".student-card").first.css("h4.student-name").text
    # location: doc.css(".student-card").first.css("p.student-location").text
    # profile_url: doc.css(".student-card").first.css("a/@href").first.value
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    binding.pry

    # twitter:
    # linkedin:
    # github:
    # blog:
    # profile_quote:
    # bio:
  end

end

#Scraper.new.scrape_index_page
