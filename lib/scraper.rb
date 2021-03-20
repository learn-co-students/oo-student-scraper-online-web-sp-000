require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        s_name = student.css('.student-name').text
        s_location = student.css('.student-location').text
        s_url = "#{student.attr('href')}"
        students << {name: s_name, location: s_location, profile_url: s_url}
      end
    end
    return students
  end


  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student = {}
    social_links = page.css(".social-icon-container").children.css("a").map { |element| element.attribute('href').value} #find each link iteratively
    social_links.each do |link| #if they have x link, assign x to a key in the hash
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    if page.css(".profile-quote")
      student[:profile_quote] = page.css(".profile-quote").text
    end
    if page.css("div.bio-content.content-holder div.description-holder p")
      student[:bio] = page.css("div.bio-content.content-holder div.description-holder p").text
    end
    return student
  end

end
