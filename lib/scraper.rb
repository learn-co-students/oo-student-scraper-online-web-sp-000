require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    students = []
    doc.css(".student-card").each{ |student_card|

      student = Hash[ :name => student_card.css(".student-name").text,
                      :location => student_card.css(".student-location").text,
                      :profile_url => student_card.css("a").attribute("href").value
                    ]
                    students << student
                    }
    return students


  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile = {}

    doc.css(".social-icon-container a").each{|a|

    if a.css("img").attribute("src").value.include?("twitter")
      profile["twitter".to_sym] = a.attribute("href").value
    elsif a.css("img").attribute("src").value.include?("linkedin")
      profile["linkedin".to_sym] = a.attribute("href").value
    elsif a.css("img").attribute("src").value.include?("github")
      profile["github".to_sym] = a.attribute("href").value
    elsif a.css("img").attribute("src").value.include?("rss")
      profile["blog".to_sym] = a.attribute("href").value
    end
    }

    profile[:profile_quote] = doc.css(".profile-quote").text

    profile[:bio] = doc.css(".description-holder p").text

        return profile
  end
end
