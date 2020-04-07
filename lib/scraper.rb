require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".card-text-container h4.student-name").text
      student_hash[:location] = student.css(".card-text-container p.student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      students_array << student_hash
    end

    students_array

  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))

    # Loop through social icons
    doc.css(".social-icon-container a").each_with_index do |icon, index|
      url = icon.attribute("href").value
      keyword = url.delete_prefix("https://").split(/(.com)/).first

      case keyword
      when "twitter"
        student_hash[:twitter] = url
      when "www.linkedin"
        student_hash[:linkedin] = url
      when "github"
        student_hash[:github] = url
      else
        student_hash[:blog] = url
      end
    end

    student_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text

    student_hash
  end

end
