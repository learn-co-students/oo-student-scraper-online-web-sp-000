require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    item = []
    url = open(index_url)
    site_parse = Nokogiri::HTML(url).css("div.student-card")
    site_parse.each do |part|
      name ={
        :name => part.css("h4.student-name").text,
        :location => part.css("p.student-location").text,
      }
      link = part.css("a").map { |a| a["href"] }
      name[:profile_url] = link[0]
      item << name
    end
    item
  end

  def self.scrape_profile_page(profile_url)
    url = open(profile_url)
    scrape = Nokogiri::HTML(url).css("div.main-wrapper")
    links = scrape.css("div.social-icon-container a").map { |a| a["href"] }
    bio   = scrape.css("div.description-holder p").text
    quote = scrape.css("div.profile-quote").text
    result = {
      :profile_quote => quote,
      :bio => bio
    }
    links.each do |link|
      result[:twitter]  = link if link.include?("twitter")
      result[:linkedin] = link if link.include?("linkedin")
      result[:github]   = link if link.include?("github")
      result[:blog]     = link if !link.include?("twitter") && !link.include?("linkedin") && !link.include?("github")
    end
    result
  end

end

