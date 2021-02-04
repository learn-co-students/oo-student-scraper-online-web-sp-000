require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    scraped_students=[]

    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student_card|

      hash = {
      :location => student_card.css("p").text,
      :name => student_card.css("h4").text,
      :profile_url => student_card.css("a").first["href"]
      }
     
      scraped_students << hash

    end
    scraped_students
  end

    def self.scrape_profile_page(profile_url)
      scraped_student = {}
      doc = Nokogiri::HTML(open(profile_url))
      social_links = doc.css(".social-icon-container")
      social_links.css("a").each do |child|

        url = child.attr('href')

      if url.include?("twitter") 
        scraped_student[:twitter] = url 
      elsif url.include?("linkedin")
        scraped_student[:linkedin] = url 
      elsif url.include?("github")
        scraped_student[:github] = url
      else
        scraped_student[:blog] = url
      end
    end

      scraped_student[:bio] = doc.css("div.description-holder p").text
      scraped_student[:profile_quote] = doc.css(".profile-quote").text

      scraped_student
    end

end