require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_info = []

    students = doc.css("div.student-card")

    students.each_with_index do |student, index|

      name = student.css("div.card-text-container h4.student-name").children.text.strip
      location = student.css("div.card-text-container p.student-location").children.text.strip
      profile = doc.css("div.student-card a")[index]["href"].strip

      student_bio = {:name => name, :location => location, :profile_url => profile}
      student_info << student_bio
    end
    student_info


  end

  def self.scrape_profile_page(profile_url)

    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    social_media = doc.css("div.social-icon-container a")

    student_info = {}

    social_media.each_with_index do |site, index|
      site_address = doc.css("div.social-icon-container a")[index]["href"]
      if site_address.include?("twitter.com")
        twitter = site_address
        student_info[:twitter] = twitter
      elsif site_address.include?("linkedin.com")
        linkedin = site_address
        student_info[:linkedin] = linkedin
      elsif site_address.include?("github.com")
        github = site_address
        student_info[:github] = github
      else
        blog = site_address
        student_info[:blog] = blog
      end
    end

    profile_quote = doc.css("div.vitals-text-container div.profile-quote").text.strip
    student_info[:profile_quote] = profile_quote

    bio = doc.css("div.bio-content div.description-holder p").text.strip
    student_info[:bio] = bio

    student_info

  end

end
