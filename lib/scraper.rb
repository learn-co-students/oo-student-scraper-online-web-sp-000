require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |card|
    card.css(".student-card a").each do |student|
      student_profile = "#{student.attr("href")}"
      student_location = student.css(".student-location").text
      student_name = student.css(".student-name").text
      students << {name: student_name, location: student_location, profile_url: student_profile}
      end
    end
    students
  end

  

  # profile_url = doc.css(".student-card").css("a").attribute("href").value
  # location = doc.css(".student-card").css(".student-location").text
  # name = doc.css(".student-card").css(".student-name").text


  # def create_project_hash
  #   html = File.read('fixtures/kickstarter.html')
  #   kickstarter = Nokogiri::HTML(html)

  #   projects = {}

  #   kickstarter.css("li.project.grid_4").each do |project|
  #     title = project.css("h2.bbcard_name strong a").text
  #     projects[title.to_sym] = {
  #       :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
  #       :description => project.css("p.bbcard_blurb").text,
  #       :location => project.css("ul.project-meta span.location-name").text,
  #       :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
  #     }
  #    end

  #    projects

  # end


  # def self.scrape_profile_page(profile_url)

  # end


end
