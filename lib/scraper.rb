require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    cards = doc.css(".student-card")
    returnArr = []
    cards.each do |card|
      name = card.css(".card-text-container").css(".student-name").text
      location = card.css(".card-text-container").css(".student-location").text
      profile_url = card.children[1].attributes["href"].value
      returnArr << {:name => name, :location => location, :profile_url => profile_url}
    end
    returnArr
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

       vitals = doc.css(".main-wrapper")

       returnHash = {}
       vitals.each do |vital|
         vital.css(".social-icon-container").children.each do |child|
          #  case child.attributes["href"].value
          # binding.pry
           if child.attributes["href"] != nil
             if child.attributes["href"].value.include?("twitter")
               returnHash[:twitter] = child.attributes["href"].value
             elsif child.attributes["href"].value.include?("linkedin")
               returnHash[:linkedin] = child.attributes["href"].value
              #  returnHash[:linkedin] = vital.css(".social-icon-container").children[1].attributes["href"].value
             elsif child.attributes["href"].value.include?("github")
               returnHash[:github] = child.attributes["href"].value
             else
               returnHash[:blog] = child.attributes["href"].value
             end
           end
         end
         returnHash[:profile_quote] = vital.css(".vitals-text-container").css(".profile-quote").children[0].text
         returnHash[:bio] = vital.css(".details-container").css(".description-holder").children[1].text
         binding.pry
       end

       returnHash
  end

end
