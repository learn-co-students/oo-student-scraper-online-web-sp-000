require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    website = Nokogiri::HTML(open(html))
    
    website.css("div.student-card"). each do |student|
    ind_student = {}
    ind_student[:name] = 
    #name = website.css("h4.student-name")
    #location = website.css("p.student-location")
    #profile_url = website.css("div.student-card")
    binding.pry

  end

  def self.scrape_profile_page(profile_url)
    
  end

end

