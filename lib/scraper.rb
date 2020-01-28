require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    
    students = []
    doc.css('.student-card').each { |card|
      student = {}
      student[:profile_url] = card.children[1].attributes["href"].value
      student[:name] = card.children[1].children[3].children[1].children[0].text
      student[:location] = card.children[1].children[3].children[3].children[0].text
      students << student
    }
    
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    attributes = {}
    doc.css('.social-icon-container').each do |social|
      social.children.each {|child|
        if child.attributes["href"] != nil
          if child.attributes["href"].value.include?("twitter")
            attributes[:twitter] = child.attributes["href"].value
          elsif child.attributes["href"].value.include?("linkedin")
            attributes[:linkedin] = child.attributes["href"].value
          elsif child.attributes["href"].value.include?("github")
            attributes[:github] = child.attributes["href"].value
          else
            attributes[:blog] = child.attributes["href"].value
          end
        end
      }
    end

    attributes[:profile_quote] = doc.css('.profile-quote').text
    attributes[:bio] = doc.css('.bio-content.content-holder div.description-holder p').text
    
    attributes
  end

end

