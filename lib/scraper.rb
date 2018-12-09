require 'open-uri'
require 'pry'
require "nokogiri"

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    html.css("div.student-card").collect do |student_card|
      student = {}
      student[:name] = student_card.css("h4.student-name").text
      student[:location] = student_card.css("p.student-location").text
      student[:profile_url] = student_card.css("a").attribute("href").value
      student
    end
  end

  def self.scrape_profile_page(profile_url)
    student_html = Nokogiri::HTML(open(profile_url))
    student = {}
    student[:bio] = student_html.css("div.bio-block p").text
    student[:twitter] = student_html.css("div.social-icon-container a[href*='twitter.com']").attribute("href").value if student_html.css("div.social-icon-container a[href*='twitter.com']")[0]
    student[:linkedin] = student_html.css("div.social-icon-container a[href*='linkedin.com']").attribute("href").value if student_html.css("div.social-icon-container a[href*='linkedin.com']")[0]
    student[:github] = student_html.css("div.social-icon-container a[href*='github.com']").attribute("href").value if student_html.css("div.social-icon-container a[href*='github.com']")[0]
    student[:blog] = student_html.css("div.social-icon-container a[href*='burgess.com']").attribute("href").value if student_html.css("div.social-icon-container a[href*='burgess.com']")[0]
    student[:profile_quote] = student_html.css("div.profile-quote").text
    student
  end

end
