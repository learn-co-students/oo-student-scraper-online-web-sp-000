require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor :students_list, :doc

  def self.scrape_index_page(index_url)
    @doc = Nokogiri::HTML(open(index_url))
    student_cards = @doc.css("div[class='student-card']").css("a")
    @students_list = []
    student_cards.each do |i|
      student_hash = {
        :name => i.css("div[class='card-text-container']").css("div").css("h4").text,
        :location => i.css("div[class='card-text-container']").css("div").css("p").text, 
        :profile_url => i.attribute("href").value
      }
      @students_list << student_hash
    end
    @students_list
  end

  def self.scrape_profile_page(profile_url)

  end

end

# puts i.css("div[class='card-text-container']").css("div").css("h4").text

# puts i.css("div[class='card-text-container']").css("div").css("p").text
# puts i.attribute("href").value
# puts "========================================================="

# doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/"))
# student_cards = doc.css("div[class='student-card']").css("a")
# student_list = []
# student_cards.each do |i|
#   student_hash = {
#         :name => i.css("div[class='card-text-container']").css("div").css("h4").text,
#         :location => i.css("div[class='card-text-container']").css("div").css("p").text, 
#         :profile_url => i.attribute("href").value
#       }
#   student_list << student_hash
# end

  