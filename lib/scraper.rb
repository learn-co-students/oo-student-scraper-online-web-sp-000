require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)
    students = []
    index_page.css("").each do |student|
      this_student = {}
      this_student[:name]
      this_student[:location]
      this_student[:profile_url]
      @@students << this_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
