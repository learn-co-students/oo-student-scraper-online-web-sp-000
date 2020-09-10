require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    student_list = []
    html = Nokogiri::HTML(open(index_url))
    students = html.css(".student-card")
    students.each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a/@href").text
      student_list << student_hash
    end
    student_list
    # student_list.sort {|a, b| a[:name] <=> b[:name]}
  end

  def self.scrape_profile_page(profile_url)
    student_profile_hash = {}
    # binding.pry
    html = Nokogiri::HTML(open(profile_url))
    social_links = html.css(".social-icon-container").css("a/@href")
    social_links.each do |link|
      if link.text.include?("twitter")
        student_profile_hash[:twitter] = link.text
      elsif link.text.include?("linkedin")
        student_profile_hash[:linkedin] = link.text
      elsif link.text.include?("github")
        student_profile_hash[:github] = link.text
      else
        student_profile_hash[:blog] = link.text
      end
    end

    student_profile_hash[:profile_quote] = html.css(".profile-quote").text
    student_profile_hash[:bio] = html.css(".description-holder").css("p").text

    student_profile_hash
  end

end
