require 'open-uri'
require 'pry'

class Scraper

  # students: page.css("div.student-card")
  # name: student.css("h4.student-name").text
  # location: student.css("p.student-location").text
  # profile_url: student.css("a").attribute("href").value

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = page.css("div.student-card")
    student_hashes = []
    students.each do |student|
      student_hashes.push(
      {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
      )
    end
    student_hashes
  end

# socials: page.css("div.social-icon-container a")
# twitter: socials[0].attribute("href").value
# linkedin: socials[1].attribute("href").value
# github: socials[2].attribute("href").value
# blog: socials[3].attribute("href").value
# profile_quote: page.css("div.profile-quote").text
# bio: page.css("div.description-holder p").text

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    social_links = page.css("div.social-icon-container a")
    social_links.each do |link_html|
      link = link_html.attribute("href").value
      if link.include? "twitter"
        student_hash[:twitter] = link
      elsif link.include? "linkedin"
        student_hash[:linkedin] = link
      elsif link.include? "github"
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end
    student_hash[:profile_quote] = page.css("div.profile-quote").text
    student_hash[:bio] = page.css("div.description-holder p").text
    student_hash
  end

end
