require 'open-uri'
require 'pry'

class Scraper

  TWITTER = "twitter-icon"
  GITHUB = "github-icon"
  LINKEDIN = "linkedin-icon"
  BLOG = "rss-icon"

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index = Nokogiri::HTML(html)

    user_cards = index.css(".student-card")

    students = []

    user_cards.each do |card|
      students << { 
        profile_url: card.css("a").attribute("href").value,
        name: card.css("a .card-text-container h4.student-name").text,
        location: card.css("a .card-text-container p.student-location").text
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)

    student_profile = {}
    student_profile[:profile_quote] = profile.css(".profile-quote").text
    student_profile[:bio] = profile.css("div.bio-block div.bio-content div.description-holder p").text

    social = profile.css(".vitals-container .social-icon-container a")

    social.each do |c|
      src = c.css("img.social-icon").attribute("src").value
      val = c.attribute("href").value
      if src.include?(TWITTER)
        student_profile[:twitter] = val
      elsif src.include?(GITHUB)
        student_profile[:github] = val
      elsif src.include?(LINKEDIN)
        student_profile[:linkedin] = val
      elsif src.include?(BLOG)
        student_profile[:blog] = val
      end
    end

    student_profile
  end

end

