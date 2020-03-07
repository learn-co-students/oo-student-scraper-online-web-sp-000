require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index = Nokogiri::HTML(open(index_url))
    index.css('.student-card').each_with_index do |card, idx|
      students[idx] = {
        name: card.css(".student-name").text,
        location: card.css(".student-location").text,
        profile_url: card.css("a")[0]['href']
      }
    end
    return students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))

    student = {
      profile_quote: page.css(".profile-quote").text,
      bio: page.css(".description-holder p").text
    }

    page.css(".social-icon-container a").each do |a|
      if a['href'].match(/twitter/)
        student[:twitter] = a['href']
      elsif a['href'].match(/github/)
        student[:github] = a['href']
      elsif a['href'].match(/linkedin/)
        student[:linkedin] = a['href']
      else
        student[:blog] = a['href']
      end
    end

    return student
  end

end
