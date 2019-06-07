require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    students = []
    cards = html.css('div.roster-cards-container div.student-card')
    cards.each do |card| 
      name = card.css('div.card-text-container h4.student-name').text
      location = card.css('div.card-text-container p.student-location').text
      url = card.css('a').attribute('href').text
      students << {name: name, location: location, profile_url: url}
    end 
    students
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url)) 
    student = {} 
    student[:bio] = html.css('div.bio-content div.description-holder p').text 
    student[:profile_quote] = html.css('div.vitals-text-container div.profile-quote').text
    #check for each link type
    links = html.css('div.social-icon-container a')
    links.each do |l| 
      l_text = l.attribute('href').text
      if l_text.include?('twitter')
        student[:twitter] = l_text
      elsif l_text.include?('linkedin') 
        student[:linkedin] = l_text 
      elsif l_text.include?('github')
        student[:github] = l_text 
      else 
        student[:blog] = l_text
      end
    end 
    student
  end
end

