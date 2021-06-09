require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    
    index_page.css("div.student-card").collect do |student|
      {:name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attr("href").value}
    end
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_hash = {}

    profile_page.css("div.social-icon-container a").each do |social|
      social_url = social.attribute("href").value
      student_hash[:twitter] = social_url if social_url.include?("twitter")
      student_hash[:linkedin] = social_url if social_url.include?("linkedin")
      student_hash[:github] = social_url if social_url.include?("github")
      student_hash[:blog] = social_url if social.css("img").attr("src").text.include?("rss")
    end
    
    student_hash[:profile_quote] = profile_page.css("div.profile-quote").text
    student_hash[:bio] = profile_page.css("div.description-holder p").text

    student_hash
  end

end

