require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    index_page.css("div.student-card").collect do |student|
        {:name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.children[1].attribute("href").value}
    end
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_page = {}
    # social_links = profile_page.css(".social-icon-container a").collect {|e| e.attributes["href"].value}
    profile_page.css("div.social-icon-container a").each do |element| 
      social_url = element.attribute("href").value
      student_page[:twitter] = social_url if social_url.include?("twitter")
      student_page[:linkedin] = social_url if social_url.include?("linkedin")
      student_page[:github] = social_url if social_url.include?("github")
      student_page[:blog] = social_url if element.css("img").attribute("src").text.include?("rss")
    end
    student_page[:profile_quote] = profile_page.css("div.profile-quote").text
    student_page[:bio] = profile_page.css("div.description-holder p").text
    student_page
  end

end

