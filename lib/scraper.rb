require 'open-uri'
require 'pry'

class Scraper
  @@students = []
  
  def self.students
    @@students
  end
  
  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card a").each do |student|
      students << {:name => student.css("h4.student-name").text,
                   :location => student.css("p.student-location").text,
                   :profile_url => student.values[0]}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end