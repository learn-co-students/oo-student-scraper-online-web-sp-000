require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |data|
      student = Student.new({})
      student.name = data.css(".card-text-container").css(".student-name").text
      student.location = data.css(".card-text-container").css(".student-location").text
      student.profile_url = data.css('a').attribute('href').value
    end
    binding.pry
    Student.all
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

