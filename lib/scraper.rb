require 'open-uri'
require 'pry'

# :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

#  doc.css("div.student-card").each do |profile|
# :name profile.css("h4.student-name").text
# :location profile.css("p.student-location").text
# :profile_url profile.css("a").first["href"]

# doc.css("div.social-icon-container").each do |social|
# :twitter
# :linkedin
# :github
# :blog   href = ref.css("a").map{|anchor| anchor["href"]}
# anchor["href"].split("/").join(".").split(".").include?("linkedin")?
# :profile_quote
# :bio
class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css("div.student-card").each do |profile|
    student_hash = {
      :name => profile.css("h4.student-name").text,
      :location => profile.css("p.student-location").text,
      :profile_url => profile.css("a").first["href"]
    }
    student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}
    ref = doc.css("div.social-icon-container")
    ref.css("a").map do |anchor|
        if anchor["href"].split("/").join(".").split(".").include?("twitter")
          profile[:twitter] = anchor["href"]
        elsif anchor["href"].split("/").join(".").split(".").include?("linkedin")
          profile[:linkedin] = anchor["href"]
        elsif anchor["href"].split("/").join(".").split(".").include?("github")
          profile[:github] = anchor["href"]
        else
          profile[:blog] = anchor["href"]
        end
    end
    profile[:profile_quote] = doc.css("div.profile-quote").text
    bio = doc.css("div.bio-content.content-holder")
    profile[:bio] = bio.css("div.description-holder").text.strip
    profile
  end

end
