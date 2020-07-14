require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    card = Nokogiri::HTML(open(index_url)).css(".student-card")
    card.each do |student|
      hash = Hash.new
      href = student.css("a").first.values
      student_name = student.css("a").first.css("h4").first.text
      student_location = student.css("a").first.css("p").first.text
      hash[:location] = student_location
      hash[:name] = student_name
      hash[:profile_url] = href.first
      students_array << hash
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    hash = Hash.new
    profile = Nokogiri::HTML(open(profile_url))
    profile_array = profile.css(".social-icon-container").css("a").collect { |social| social.values }
    profile_array.each do |link|
      x = link.first.split(".")
      x.pop
      if x.size == 2
        site = x.pop
      else
        site = x.first.split("/").pop
      end
      if site == "github"
        hash[:github] = link.first
      elsif site == "linkedin"
        hash[:linkedin] = link.first
      elsif site == "twitter"
        hash[:twitter] = link.first
      elsif site == "youtube"
        hash[:youtube] = link.first
      else
        hash[:blog] = link.first
      end
    end
    if profile.css(".profile-quote").children != []
      hash[:profile_quote] = profile.css(".profile-quote").children.first.text
    end
    if profile.css(".description-holder").first.css("p").children != []
      hash[:bio] = profile.css(".description-holder").first.css("p").children.first.text
    end
    hash
  end

end

