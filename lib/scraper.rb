require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

arr = []

doc.css("div.student-card").each do |card|
hash = {}
hash[:name] = card.css("h4.student-name").text
hash[:location] = card.css("a/div.card-text-container/p").text
hash[:profile_url] = card.css("a/@href").text
arr << hash
end


 return arr
  end

  def self.scrape_profile_page(profile_url)
doc = Nokogiri::HTML(open(profile_url))

  student = {}
 student[:bio] = doc.css("div.description-holder p").text
  student[:profile_quote] = doc.css("div.profile-quote").text#.tr('"', '')
  arr = []
  doc.css("div.social-icon-container/a/@href").each do |x|
    arr << x.value
    end
  arr.each do |x|
  if x.include?("twitter")
  student[:twitter] = x
   elsif x.include?("linkedin")
   student[:linkedin] = x
   elsif x.include?("github")
   student[:github] = x
 elsif x != nil
   student[:blog] = x
   end
   end


#binding.pry
return student

  end

end
