require 'open-uri'
require 'pry'
# require 'Nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    page.css("div.student-card").collect do |student|
      s_name = student.css("h4.student-name")
      s_local = student.css("p.student-location").text
      s_url = student.css("a").attr("href").value
      {name: s_name, location: s_local, profile_url: s_url}
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

