require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper
  attr_accessors :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/index.html')
    learn = Nokogiri::HTML(html)

    students = []
    learn.css("li.project.grid_4").each do |element|
      #body > div > div > div.roster-cards-container
      #name--> h1 class= "profile-name"
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
    :name => learn.css("h1.profile-name").text,
    :location => project.css("ul.project-meta span.location-name").text,
    :profile_url => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
  }
end

# return the projects hash
projects

  end

  def self.scrape_profile_page(profile_url)

  end

end
