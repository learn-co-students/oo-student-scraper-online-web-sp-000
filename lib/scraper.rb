require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card a")
    student_array = []
    students.each do |student|
      
    student_array << {:name => student.css("h4.student-name").text.strip,
    :location => ,
    :profile_url =>  }
    binding.pry
  end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

