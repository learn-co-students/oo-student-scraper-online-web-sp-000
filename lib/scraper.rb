require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
     doc=Nokogiri::HTML(open(index_url))
     array=[]
     binding.pry
     doc.css(".student-card").first.each do |a|
         student={}
         student.fetch(:name,"a.css("h4").text")
         student[:location]=a.css("p").text
         student[:profile_url]=a.css("a")[0]['href']
         array<<student
      end
      array
  end

  def self.scrape_profile_page(profile_url)

  end

end

Scraper.scrape_index_page("fixtures/student-site/index.html")
