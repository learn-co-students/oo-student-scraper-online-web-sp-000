require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
    students = Nokogiri::HTML(html)

    students = {}
puts "hello"
binding.pry
    students.css("div.student-card").each do |student|
      puts "hello"
  #title = project.css("h2.bbcard_name strong a").text
  #student[title.to_sym] = {
    #:name => project.css("p.bbcard_blurb").text,
    #:location => project.css("ul.project-meta span.location-name").text,
    #:profile_url => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
  #}
end
  end

  def self.scrape_profile_page(profile_url)

  end

end
