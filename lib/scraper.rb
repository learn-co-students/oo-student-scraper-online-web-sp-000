require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #pulls the html into the doc variable
    doc = Nokogiri::HTML(open(index_url))
    all_students = []

    #grabs all student cards, and for each, adds their name, location, and url to an array
    doc.css(".student-card a").each do |student|
      student = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.attribute("href").value
      }
      all_students << student
    end
    all_students
  end

  #scrapes a user's profile for their social links, and bio info
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {
      :profile_quote => doc.css("div .profile-quote").text,
      :bio => doc.css(".bio-content .description-holder p").text,
    }

    self.social_link_assignment(doc.css("div .social-icon-container a"), student_hash)

    student_hash
  end

  #adds links to the student's hash if their exists a link for each site
  def self.social_link_assignment(social_links, student_hash)
    social_links.each do |anchor|
      if anchor.attribute("href").value.include?("twitter")
        student_hash[:twitter] = anchor.attribute("href").value
      elsif anchor.attribute("href").value.include?("linkedin")
        student_hash[:linkedin] = anchor.attribute("href").value
      elsif anchor.attribute("href").value.include?("github")
        student_hash[:github] = anchor.attribute("href").value
      #for this last one, if there is a link that is not any of the above sites, then it is the blog
      elsif anchor.attribute("href").value != ""
        student_hash[:blog] = anchor.attribute("href").value
      end
    end
  end
end
