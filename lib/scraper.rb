require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
    students_page = Nokogiri::HTML(html)

    students = []

    students_page.css("div.student-card").each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
      students << {:name => name.to_sym, :location => location.to_sym, :profile_url => profile_url.to_sym}
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
