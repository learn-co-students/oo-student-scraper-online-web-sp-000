require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_info = []
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |student|
    #  binding.pry
      hash = {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
      student_info << hash
    end
    student_info
  end

  def self.scrape_profile_page(index_url)
    student_profile = {}
    html = Nokogiri::HTML(open(index_url))
    url = html.css(".social-icon-container a").map do |link|
        link["href"]
      end
    url.each do |url|
      #student_profile[:blog] = url if url.include?(html.css("vitals-text-container profile-name").text.downcase)
      student_profile[:twitter] = url if url.include?("twitter")
      student_profile[:linkedin] = url if url.include?("linkedin")
      student_profile[:github] = url if url.include?("github")
      student_profile[:blog] = url if url.include?("http://")
    end
      student_profile[:profile_quote] = html.css(".vitals-text-container div").text
      student_profile[:bio] = html.css(".description-holder p").text
#binding.pry
      student_profile
  end
end
