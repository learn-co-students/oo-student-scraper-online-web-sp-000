require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css('div.student-card')
    students.map do |student|
    {name: student.css('h4.student-name').text,
      location: student.css('p.student-location').text,
      profile_url: student.css('a').first['href']}
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    links = doc.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = doc.css('div.profile-quote').text
    student[:bio] = doc.css('div.description-holder p').text
    student
  end

end
