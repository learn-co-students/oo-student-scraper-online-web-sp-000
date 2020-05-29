require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = Array.new
    html_doc = Nokogiri::HTML(open(index_url))

    html_doc.css(".student-card").each do |card|
      # binding.pry
      # puts card.css(".student-name").text,
      # puts card.css(".student-location").text,
      # puts card.css("a")['href']
      students << {
        name: card.css(".student-name").text,
        location: card.css(".student-location").text,
        profile_url: card.css("a")[0]['href']
      }
    end
    
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    link_box = doc.css("div.social-icon-container a").map {|h| h['href']}
    a = {
      twitter: link_box.find {|a| a.match /twitter.com/},
      linkedin: link_box.find {|a| a.match /linkedin.com/},
      github: link_box.find {|a| a.match /github.com/},
      blog: link_box.find {|a| a !~ /(github|linkedin|twitter)/},
      profile_quote: doc.css("div.profile-quote").text,
      bio: doc.css("div.description-holder p").text
    }
    # binding.pry
    return a
  end

end

