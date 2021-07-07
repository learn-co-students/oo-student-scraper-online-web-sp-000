require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css("div.student-card").collect do |student|
      bob= {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attr("href").value
    }
     #binding.pry
    end
  end


  def self.scrape_profile_page(profile_url)
    docs = Nokogiri::HTML(open(profile_url))

    profile = {}
# needing linkedin, github, and blog
    profile[:bio] = docs.css("div.description-holder p").text
    profile[:profile_quote] = docs.css("div.profile-quote").text

    links = docs.css("div.social-icon-container a")
    links_array = links.map { |e| e["href"] }
      links_array.each do |i|
        profile[:linkedin] = i if i.include?("linkedin")
        profile[:github] = i if i.include?("github")
        profile[:twitter] = i if i.include?("twitter")
        profile[:blog] = i if !profile.has_value?(i)
      end
      profile
      # binding.pry
    end

end
