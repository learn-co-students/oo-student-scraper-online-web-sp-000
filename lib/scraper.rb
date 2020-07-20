require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

#students: doc.css(".student-card")
#profile_url: student.css("a").attribute("href").value
#location: student.css("p").text

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []
    doc.css(".student-card").each{ |student_card|
      student = Hash[ "name" => student_card.css("h4").text,
                      "location" => student_card.css("p").text,
                      "profile_url" => student_card.css("a").attribute("href").value
                    ]
                    students << student
                    }
    return students


  end

# twitter: doc.css(".social-icon-container a").first.attribute("href").value
# linkedin:

  def self.scrape_profile_page(profile_url)
doc = Nokogiri::HTML(open(profile_url))
profile = {}
doc.css(".social-icon-container a").each{|link|
    if link.attribute("href").value.include?("twitter")
      profile[:twitter] = doc.css(".social-icon-container a").first.attribute("href").value
    end

    if link.attribute("href").value.include?("linkedin")
      profile[:linkedin] = doc.css(".social-icon-container a").first.attribute("href").value
    end

    if link.attribute("href").value.include?("github")
      profile[:github] = doc.css(".social-icon-container a").first.attribute("href").value
    end

    if link.attribute("href").value.include?("blog")
      profile[:blog] = doc.css(".social-icon-container a").first.attribute("href").value
    end
    }

    profile[:profile_quote] = doc.css(".profile-quote").text

    profile[:bio] = doc.css(".description-holder p").text
  end

end
