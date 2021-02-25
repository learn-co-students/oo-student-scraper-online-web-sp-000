require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(doc)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    students = []

    roster = doc.css(".roster-cards-container")
    roster.each do |card|
      card.css(".student-card a").each do |student|
      student_name = student.css(".student-name").text
      student_location = student.css(".student-location").text
      student_url = student.attr("href")
      students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    students
  end

  def self.scrape_profile_page(url)
    profile_page = Nokogiri::HTML(open(url))
    student = {}
    personal_links = profile_page.css(".social-icon-container").children.css("a").map {|lk| lk.attribute("href").value}
    personal_links.each do |link|
    if link.include?("linkedin")
      student[:linkedin] = link
    elsif link.include?("twitter")
      student[:twitter] = link
    elsif link.include?("github")
      student[:github] = link
    else
      student[:blog] = link
      end
    end
    student[:bio] = profile_page.css(".description-holder").children.css("p").text
    student[:profile_quote] = profile_page.css(".profile-quote").children.text
    student
  end

end
